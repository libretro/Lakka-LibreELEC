"""Utility functions for copying files and directory trees.

XXX The functions here don't copy the resource fork or other metadata on Mac.


shutil2 (22/12/08)
by Frost and Temhil
Version unofficial of shutil, shutil2 is based on current SVN revision 65644.
This version includes 'overwrite' file and 'reportcopy' during process

"""

import os
import sys
import stat
from os.path import abspath
import fnmatch

__all__ = ["copyfileobj","copyfile","copymode","copystat","copy","copy2",
           "copytree","move","rmtree","Error"]

class Error(EnvironmentError):
    pass

try:
    WindowsError
except NameError:
    WindowsError = None

# exception raised when copied size does not match content-length
class ContentTooShortError(IOError):
    def __init__(self, message, content):
        IOError.__init__(self, message)
        self.content = content

def copyfileobj(fsrc, fdst, reportcopy=None, size=1, length=16*1024):
    """copy data from file-like object fsrc to file-like object fdst"""
    result = "", str(size)
    read = 0
    blocknum = 0
    if reportcopy:
        reportcopy(blocknum, length, size)
    while 1:
        buf = fsrc.read(length)
        if not buf:
            break
        read += len(buf)
        fdst.write(buf)
        blocknum += 1
        if reportcopy:
            reportcopy(blocknum, length, size)

    # raise exception if actual size does not match
    if size >= 0 and read < size:
        raise ContentTooShortError("copying incomplete: got only %i out "
                                   "of %i bytes" % (read, size), result)

def _samefile(src, dst):
    # Macintosh, Unix.
    if hasattr(os.path,'samefile'):
        try:
            return os.path.samefile(src, dst)
        except OSError:
            return False

    # All other platforms: check for same pathname.
    return (os.path.normcase(os.path.abspath(src)) ==
            os.path.normcase(os.path.abspath(dst)))

def copyfile(src, dst, reportcopy=None, overwrite=False):
    """Copy data from src to dst"""
    if _samefile(src, dst):
        raise Error, "`%s` and `%s` are the same file" % (src, dst)

    fsrc = None
    fdst = None
    try:
        fsrc = open(src, 'rb')
        if os.path.exists(dst) and overwrite:
            os.remove(dst)
        fdst = open(dst, 'wb')
        try: size = os.stat(src)[6]/1024.0
        except: size = 1
        copyfileobj(fsrc, fdst, reportcopy, size)
    finally:
        if fdst:
            fdst.close()
        if fsrc:
            fsrc.close()

def copymode(src, dst):
    """Copy mode bits from src to dst"""
    if hasattr(os, 'chmod'):
        st = os.stat(src)
        mode = stat.S_IMODE(st.st_mode)
        os.chmod(dst, mode)

def copystat(src, dst):
    """Copy all stat info (mode bits, atime, mtime, flags) from src to dst"""
    st = os.stat(src)
    mode = stat.S_IMODE(st.st_mode)
    if hasattr(os, 'utime'):
        os.utime(dst, (st.st_atime, st.st_mtime))
    if hasattr(os, 'chmod'):
        os.chmod(dst, mode)
    if hasattr(os, 'chflags') and hasattr(st, 'st_flags'):
        os.chflags(dst, st.st_flags)

def copy(src, dst, reportcopy=None, overwrite=False):
    """Copy data and mode bits ("cp src dst").

    The destination may be a directory.

    """
    if os.path.isdir(dst):
        dst = os.path.join(dst, os.path.basename(src))
    copyfile(src, dst, reportcopy, overwrite)
    copymode(src, dst)

def copy2(src, dst, reportcopy=None, overwrite=False):
    """Copy data and all stat info ("cp -p src dst").

    The destination may be a directory.

    """
    if os.path.isdir(dst):
        dst = os.path.join(dst, os.path.basename(src))
    copyfile(src, dst, reportcopy, overwrite)
    copystat(src, dst)

def ignore_patterns(*patterns):
    """Function that can be used as copytree() ignore parameter.

    Patterns is a sequence of glob-style patterns
    that are used to exclude files"""
    def _ignore_patterns(path, names):
        ignored_names = []
        for pattern in patterns:
            ignored_names.extend(fnmatch.filter(names, pattern))
        return set(ignored_names)
    return _ignore_patterns

def copytree(src, dst, symlinks=False, ignore=None, reportcopy=None, overwrite=False):
    """Recursively copy a directory tree using copy2().

    The destination directory must not already exist.
    If exception(s) occur, an Error is raised with a list of reasons.

    If the optional symlinks flag is true, symbolic links in the
    source tree result in symbolic links in the destination tree; if
    it is false, the contents of the files pointed to by symbolic
    links are copied.

    The optional ignore argument is a callable. If given, it
    is called with the `src` parameter, which is the directory
    being visited by copytree(), and `names` which is the list of
    `src` contents, as returned by os.listdir():

        callable(src, names) -> ignored_names

    Since copytree() is called recursively, the callable will be
    called once for each directory that is copied. It returns a
    list of names relative to the `src` directory that should
    not be copied.

    XXX Consider this example code rather than the ultimate tool.

    """
    names = os.listdir(src)
    if ignore is not None:
        ignored_names = ignore(src, names)
    else:
        ignored_names = set()
    if not os.path.exists(dst) or not overwrite:
        os.makedirs(dst)
    errors = []
    for name in names:
        if name in ignored_names:
            continue
        srcname = os.path.join(src, name)
        dstname = os.path.join(dst, name)
        try:
            if symlinks and os.path.islink(srcname):
                linkto = os.readlink(srcname)
                os.symlink(linkto, dstname)
            elif os.path.isdir(srcname):
                copytree(srcname, dstname, symlinks, ignore, reportcopy, overwrite)
            else:
                copy2(srcname, dstname, reportcopy, overwrite)
            # XXX What about devices, sockets etc.?
        except (IOError, os.error), why:
            errors.append((srcname, dstname, str(why)))
        # catch the Error from the recursive copytree so that we can
        # continue with other files
        except Error, err:
            errors.extend(err.args[0])
    try:
        copystat(src, dst)
    except OSError, why:
        if WindowsError is not None and isinstance(why, WindowsError):
            # Copying file access times may fail on Windows
            pass
        elif overwrite:
            pass
        else:
            errors.extend((src, dst, str(why)))
    if errors:
        raise Error, errors

def rmtree(path, ignore_errors=False, onerror=None):
    """Recursively delete a directory tree.

    If ignore_errors is set, errors are ignored; otherwise, if onerror
    is set, it is called to handle the error with arguments (func,
    path, exc_info) where func is os.listdir, os.remove, or os.rmdir;
    path is the argument to that function that caused it to fail; and
    exc_info is a tuple returned by sys.exc_info().  If ignore_errors
    is false and onerror is None, an exception is raised.

    """
    if ignore_errors:
        def onerror(*args):
            pass
    elif onerror is None:
        def onerror(*args):
            raise
    try:
        if os.path.islink(path):
            # symlinks to directories are forbidden, see bug #1669
            raise OSError("Cannot call rmtree on a symbolic link")
    except OSError:
        onerror(os.path.islink, path, sys.exc_info())
        # can't continue even if onerror hook returns
        return
    names = []
    try:
        names = os.listdir(path)
    except os.error, err:
        onerror(os.listdir, path, sys.exc_info())
    for name in names:
        fullname = os.path.join(path, name)
        try:
            mode = os.lstat(fullname).st_mode
        except os.error:
            mode = 0
        if stat.S_ISDIR(mode):
            rmtree(fullname, ignore_errors, onerror)
        else:
            try:
                os.remove(fullname)
            except os.error, err:
                onerror(os.remove, fullname, sys.exc_info())
    try:
        os.rmdir(path)
    except os.error:
        onerror(os.rmdir, path, sys.exc_info())


def _basename(path):
    # A basename() variant which first strips the trailing slash, if present.
    # Thus we always get the last component of the path, even for directories.
    return os.path.basename(path.rstrip(os.path.sep))

def move(src, dst, reportcopy=None, overwrite=False):
    """Recursively move a file or directory to another location. This is
    similar to the Unix "mv" command.

    If the destination is a directory or a symlink to a directory, the source
    is moved inside the directory. The destination path must not already
    exist.

    If the destination already exists but is not a directory, it may be
    overwritten depending on os.rename() semantics.

    If the destination is on our current filesystem, then rename() is used.
    Otherwise, src is copied to the destination and then removed.
    A lot more could be done here...  A look at a mv.c shows a lot of
    the issues this implementation glosses over.

    """
    real_dst = dst
    if os.path.isdir(dst):
        real_dst = os.path.join(dst, _basename(src))
        if os.path.exists(real_dst):
            raise Error, "Destination path '%s' already exists" % real_dst
    try:
        os.rename(src, real_dst)
    except OSError:
        if os.path.isdir(src):
            if destinsrc(src, dst):
                raise Error, "Cannot move a directory '%s' into itself '%s'." % (src, dst)
            #copytree(src, dst, symlinks=True)
            copytree(src, dst, True, reportcopy, overwrite)
            rmtree(src)
        else:
            copy2(src, real_dst, reportcopy, overwrite)
            os.unlink(src)

def reportcopy(blocknum, blocksize, totalsize):
    # Report during remote transfers
    print "Block number: %d, Block size: %d, Total size: %d" % (
        blocknum, blocksize, totalsize)

def destinsrc(src, dst):
    return abspath(dst).startswith(abspath(src))
