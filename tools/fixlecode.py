#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

import os
import sys
import re
import argparse
import subprocess
import tempfile

VAR_VALID_CHARS = '[A-Za-z_0-9]'

RE_VAR_VALID_CHARS = re.compile(VAR_VALID_CHARS)

RE_APPEND_WITH_BRACES = re.compile(r'^\s*(%s*)="(\${%s*})' % (VAR_VALID_CHARS, VAR_VALID_CHARS))
RE_APPEND_WITHOUT_BRACES = re.compile(r'^\s*(%s*)="(\$%s*)' % (VAR_VALID_CHARS, VAR_VALID_CHARS))

RE_AWK_SQUOTE1 = re.compile(r".*\s*awk -F'.' [^']*\s'([^']*)'")
RE_AWK_SQUOTE2 = re.compile(r".*\s*awk[^']*\s'([^']*)'")
RE_AWK_DQUOTE = re.compile(r'.*\s*awk[^"]*\s"([^"]*)"')

RE_SEMICOLON_THEN = re.compile(r'\s*;\s*then\s*$')
RE_SEMICOLON_DO = re.compile(r'\s*;\s*do\s*$')

RE_CONTINUATION = re.compile(r'.*\\\s*')
RE_SIMPLE_ASSIGN = re.compile(r'\s*%s*="[^"]*"\s*$' % VAR_VALID_CHARS)

#
# From:
#   PKG_XYZ="$PKG_XYZ blah" (or PKG_XYZ="${PKG_XYZ} blah")
# to
#   PKG_XYZ+=" blah"
#
def fix_appends(line, changed):
  changes = 0
  newline = line
  replace = False

  # If it doesn't look like a simple 'PKG_XYZ="<something>"' then ignore it
  if not RE_SIMPLE_ASSIGN.match(line):
    return newline

  # Ignore continuations, likely not a simple assignment
  if RE_CONTINUATION.match(line):
    return newline

  match = RE_APPEND_WITH_BRACES.match(line)
  if match:
    replace = (match.groups()[1] == ('${%s}' % match.groups()[0]))
  else:
    match = RE_APPEND_WITHOUT_BRACES.match(line)
    if match:
      replace = (match.groups()[1] == ('$%s' % match.groups()[0]))

  # If we want to replace this, but we're replacing the var
  # with only itself, then it's not a concat but something else,
  # so ignore it (eg. when populating /etc/os-release in /scripts/image).
  if replace and line.endswith('%s"\n' % match.groups()[1]):
    replace = False

  if replace:
    newline = line.replace('="%s' % match.groups()[1], '+="')
    changes += 1

  changed['appends'] += changes
  changed['isdirty'] = (changed['isdirty'] or changes != 0)

  return newline

#
# From:
#   $PKG_XYZ
# to:
#   ${PKG_XYZ}
#
def fix_braces(line, changed):
  changes = 0
  newline = ''
  invar = False
  c = 0

  # Try and identify awk progs, so that they can be ignored
  awk = None
  for r in [RE_AWK_SQUOTE1, RE_AWK_SQUOTE2, RE_AWK_DQUOTE]:
    awk = r.match(line)
    if awk:
      break

  while c < len(line):
    char = line[c:c+1]
    charn = line[c+1:c+2]

    # ignore $0, $1, $2 etc. in simple one-line awk progs
    if awk and c >= awk.start(1) and c <= awk.end(1):
      newline += char
      c += 1
      continue

    if not invar and char == '$' and RE_VAR_VALID_CHARS.search(charn):
      invar = True
      newline += char + '{'
      changes += 1
    elif invar and not RE_VAR_VALID_CHARS.search(char):
      invar = False
      newline += '}'
      if char == '$':
        continue
      newline += char
    else:
      newline += char
    c +=1

  changed['braces'] += changes
  changed['isdirty'] = (changed['isdirty'] or changes != 0)

  return newline

#
# From
#   blah=`cat filename | wc -l`
# to:
#   blah=$(cat filename | wc -l)
#
def fix_backticks(line, changed):
  changes = 0
  newline = ''
  intick = False
  iscomment = False
  c = 0

  # Don't fix backticks in comments as more likely to be markdown
  if line.startswith('#'):
    return line

  while c < len(line):
    char = line[c:c+1]
    charn = line[c+1:c+2]

    # Don't convert "embedded" comments such as `# blah blah`
    if not intick and char == '`' and charn == '#':
      iscomment = True

    if char == '`' and (intick or charn != '#'):
      if iscomment:
        newline += char
        iscomment = False
      elif not intick:
        newline += '$('
        changes += 1
      else:
        newline += ')'
      intick = not intick
    else:
      newline += char

    c += 1

  changed['backticks'] += changes
  changed['isdirty'] = (changed['isdirty'] or changes != 0)

  return newline

#
# 1. From:
#      if [ test ] ; then
#    to:
#      if [ test ]; then
#
# 2. From:
#      for dtb in $(find . -name '*.dtb') ; do
#    to:
#      for dtb in $(find . -name '*.dtb'); do
#
def fix_semicolons(line, changed):
  changes = 0
  newline = line

  oldline = newline
  newline = RE_SEMICOLON_THEN.sub('; then\n', newline)
  if newline != oldline:
    changes += 1

  oldline = newline
  newline = RE_SEMICOLON_DO.sub('; do\n', newline)
  # Hack around dangling '   ; do' statements
  if newline == '; do\n':
    newline = oldline
  if newline != oldline:
    changes += 1

  changed['semicolons'] += changes
  changed['isdirty'] = (changed['isdirty'] or changes != 0)

  return newline

#
# Validate args.
# Iterate over files.
#
def process_args(args):
  files = []

  if args.filename:
    for filename in args.filename:
      if os.path.exists(filename):
        if os.path.isfile(filename):
          files.append(filename)
      else:
        print('ERROR: %s does not exist' % filename)
        sys.exit(1)
  else:
    if args.write:
        print('ERROR: --write not valid when input is stdin.')
        sys.exit(1)
    files.append(None) #read from stdin

  if len(files) > 1 and args.output:
      print('ERROR: --output not valid with multiple inputs.')
      sys.exit(1)

  for filename in sorted(files):
    (oldlines, newlines, changed) = process_file(filename, args)

    if args.output:
      output_file(args.output, newlines)
    elif args.write:
      output_file(filename, newlines)

    if args.diff and changed['isdirty']:
      show_diff(filename, oldlines, newlines)

    if not args.quiet and (not args.dirty or changed['isdirty']):
      show_summary(filename, changed)

def process_file(filename, args):
  oldlines = []
  newlines = []

  changed = {'isdirty': False, 'appends': 0, 'backticks': 0, 'braces': 0, 'semicolons': 0}

  if filename:
    file = open(filename, 'r')
  else:
    file = sys.stdin

  oldline = file.readline()
  while oldline:
    oldlines.append(oldline)
    oldline = file.readline()

  file.close()

  for oldline in oldlines:
    newline = oldline

    if not args.no_appends:
      newline = fix_appends(newline, changed)

    if not args.no_braces:
      newline = fix_braces(newline, changed)

    if not args.no_backticks:
      newline = fix_backticks(newline, changed)

    if not args.no_semicolons:
      newline = fix_semicolons(newline, changed)

    newlines.append(newline)

  return(''.join(oldlines), ''.join(newlines), changed)

def run_command(command):
  result = ''
  process = subprocess.Popen(command, shell=True, close_fds=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  process.wait()
  for line in process.stdout.readlines():
    result = '%s%s' % (result, line.decode('utf-8'))
  return result

#
# Run 'diff -Naur' on two inputs.
#
# Since we support input from stdin, write
# both sets of data to temporary files and
# then compare them.
#
def show_diff(filename, oldlines, newlines):
  if not filename:
    filename = 'stdin'

  with tempfile.NamedTemporaryFile(mode='w') as file:
    oldfile = file.name

  with tempfile.NamedTemporaryFile(mode='w') as file:
    newfile = file.name

  output_file(oldfile, oldlines)
  output_file(newfile, newlines)

  diff = run_command('diff -Naur "%s" "%s"' % (oldfile, newfile))

  os.remove(oldfile)
  os.remove(newfile)

  diff = diff.split('\n')
  if len(diff) > 2:
    # fix filenames
    diff[0] = diff[0].replace(oldfile, 'a/%s' % filename)
    diff[1] = diff[1].replace(newfile, 'b/%s' % filename)
    print('\n'.join(diff), file=sys.stderr)

def output_file(filename, lines):
  if filename == '-':
    print(lines, end='')
  else:
    with open(filename, 'w') as file:
      print(lines, end='', file=file)

def show_summary(filename, changed):
  print()
  if not filename:
    print('Summary of changes', file=sys.stderr)
  else:
    print('Summary of changes [%s]' % filename, file=sys.stderr)
  print('==================', file=sys.stderr)
  print('Appends   : %4d' % changed['appends'], file=sys.stderr)
  print('Braces    : %4d' % changed['braces'], file=sys.stderr)
  print('Backticks : %4d' % changed['backticks'], file=sys.stderr)
  print('Semicolons: %4d' % changed['semicolons'], file=sys.stderr)

#---------------------------------------------
parser = argparse.ArgumentParser(description='Update build system shell-script source ' \
                                             'code to comply with LibreELEC coding standards.\n\n' \
                                             'Should work with package.mk, and other build system shell ' \
                                             'scripts (scripts/*, config/* etc.).\n\n' \
                                             'WARNING: May produce unusable results when run on ' \
                                             'non-shell script code!', \
                                 formatter_class=argparse.RawDescriptionHelpFormatter)

parser.add_argument('-f', '--filename', nargs='+', metavar='FILENAME', required=False, \
                    help='Filename to be read. If not supplied, read from stdin.')

group = parser.add_mutually_exclusive_group()
group.add_argument('-o', '--output', metavar='FILENAME', required=False, \
                    help='Optional filename into which output will be written. ' \
                         'Use - for stdout. Not valid with more than one input, or --write.')

group.add_argument('-w', '--write', action='store_true', \
                    help='Overwrite --filename with changes. Default is not to overwrite. ' \
                         'Not valid if --output is specified, or reading from stdin.')
parser.add_argument('-d', '--diff', action='store_true', \
                    help='Output diff of changes to stderr (diff -Naur).')

group = parser.add_mutually_exclusive_group()
group.add_argument('-q', '--quiet', action='store_true', help='Disable summary.')
group.add_argument('-Q', '--dirty', action='store_true', help='Output summary only for modified files.')

parser.add_argument('-xa', '--no-appends', action='store_true', help='Disable "append" (+=) conversion.')

parser.add_argument('-xb', '--no-braces', action='store_true', help='Disable "brace" ({}) addition.')

parser.add_argument('-xs', '--no-semicolons', action='store_true', help='Disable "semicolon squeezing" ( ;/;).')

parser.add_argument('-xt', '--no-backticks', action='store_true', help='Disable "backtick" (``/$()) replacement.')

args = parser.parse_args()

if __name__ == '__main__':
  process_args(args)
