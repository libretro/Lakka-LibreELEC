#!/bin/bash
set -e

BIN=$(readlink -f $(dirname $0))

if git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "Don't run this script inside a git reppository!"
  exit 1
fi

DEPTH=1000

usage()
{
  local me="$(basename $0)"

  echo "Usage:   ${me} <popcornmix-branch> <sha>|<xbmc branch>"
  echo
  echo "Example: ${me} jarvis_rbp_backports d11fabefb909e75e7186bd9ecd0cbff9e8b24577"
  echo "Example: ${me} jarvis_rbp_backports Jarvis"
  echo "Example: ${me} newclock5 master"
  echo
  echo "For sha, see https://github.com/xbmc/xbmc/compare/Jarvis...popcornmix:jarvis_rbp_backports (replace branches as appropriate)"
  exit 1
}

if [ -z "${1}" ]; then
  echo "ERROR: popcornmix branch must be specified!"
  echo
  usage
fi

if [ -z "${2}" ]; then
  echo "ERROR: First popcornmix revision (sha) or name of xbmc branch must be specified!"
  echo
  usage
fi

BRANCH="$1"
BASEREV="$2"

rm -fr raspberrypi-kodi

# If we have a persisted version of the repo, quickly copy it
if [ -d raspberrypi-kodi.stash ]; then
  echo "Copying raspberrypi-kodi.stash raspberrypi-kodi..."
  cp -r raspberrypi-kodi.stash raspberrypi-kodi
  cd raspberrypi-kodi
  git checkout ${BRANCH}
else
  git clone -b ${BRANCH} --depth=${DEPTH} --single-branch https://github.com/popcornmix/xbmc.git raspberrypi-kodi
  cd raspberrypi-kodi
fi

if [[ ${BASEREV} =~ [0-9a-f]{40} ]]; then
  BASEREV="${BASEREV}~1"
else
  git remote add -t ${BASEREV} xbmc https://github.com/xbmc/xbmc.git
  BASEREV="xbmc/${BASEREV}"
fi

# Apply the following config change to reduce chance of duplicate hashes
git config --local core.abbrev 40

git fetch --all --depth=${DEPTH}
git reset --hard origin/${BRANCH}

TOPREV="$(git log --oneline --grep "UNSTABLE: This is a placeholder. Commits after this point are considered experimental." | awk '{print $1}')"
if [ -n "${TOPREV}" ]; then
  echo "Found UNSTABLE placeholder with rev ${TOPREV}, making this the new HEAD"
  git reset --hard ${TOPREV}
else
  echo "WARNING: UNSTABLE placeholder not found, assuming it is not present in branch ${BRANCH}"
fi

if [ -d addons/skin.confluence ]; then
  SKIN1=skin.confluence
  SKIN2=kodi-theme-Confluence
else
  SKIN1=skin.estuary
  SKIN2=kodi-theme-Estuary
fi

GIT_SEQUENCE_EDITOR=${BIN}/rpi-kodi-rebase.sh git rebase -i ${BASEREV}
git format-patch --no-signature --stdout ${BASEREV} >/tmp/kodi.patch

cd .. && rm -fr raspberrypi-kodi

echo
echo "New kodi patch: /tmp/kodi.patch"

echo
echo "## LibreELEC Update Notes ##"
echo
echo "cd LibreELEC.tv"
echo "git checkout master"
echo "git pull upstream master"
echo "git checkout -b somebranch"

BRANCH="${BRANCH//_/-}"

echo
if [ -s /tmp/kodi.patch ]; then
  echo "cp /tmp/kodi.patch projects/RPi/patches/kodi/kodi-001-backport.patch"
  echo "git commit -am \"RPi: Update kodi support patch\""
else
  echo "NO KODI PATCH REQUIRED"
fi

echo
