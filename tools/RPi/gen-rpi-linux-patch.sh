#!/bin/bash
set -e

BIN=$(readlink -f $(dirname $0))

if git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "Don't run this script inside a git reppository!"
  exit 1
fi

DEPTH=1000
BRANCH="$1"
[ -n "${2}" ] && REBASE="_rebase"

usage()
{
  local me="$(basename $0)"

  echo "Usage:   ${me} <major.minor>|<major.minor.patch> [rebase]"
  echo
  echo "Example: 4.4 (for rpi-4.4.y) or 4.4.6 - specifying an exact kernel version avoids fetching the upstream repo"
  echo "         4.4 rebase  - use rpi-4.4.y_rebase branch"
  echo "         4.6-rc6"
  exit 1
}

if [ -z "${BRANCH}" ]; then
  echo "ERROR: Branch must be specified!"
  echo
  usage
fi

if [[ ${BRANCH} =~ [0-9]*\.[0-9]*\.[0-9]* ]]; then
  KERNEL="${BRANCH}"
  BRANCH="${BRANCH%.*}"
elif [[ ${BRANCH} =~ [0-9]*\.[0-9]*-rc[0-9] ]]; then
  KERNEL="${BRANCH}"
  BRANCH="${BRANCH%-*}"
fi

rm -fr raspberrypi-linux

# If we have a persisted version of the repo, quickly copy it
if [ -d raspberrypi-linux.stash ]; then
  echo "Copying raspberrypi-linux.stash to raspberrypi-linux..."
  cp -r raspberrypi-linux.stash raspberrypi-linux
  cd raspberrypi-linux
  git checkout rpi-${BRANCH}.y${REBASE}
else
  git clone -b rpi-${BRANCH}.y${REBASE} --depth=${DEPTH} --single-branch https://github.com/raspberrypi/linux.git raspberrypi-linux
  cd raspberrypi-linux
fi

if [ -z "${KERNEL}" ]; then
  git remote add -t linux-${BRANCH}.y linux-stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
fi

git fetch --all --depth=${DEPTH}
git reset --hard origin/rpi-${BRANCH}.y${REBASE}

if [ -z "${KERNEL}" ]; then
  BASEREV="linux-stable/linux-${BRANCH}.y"
else
  BASEREV="$(git log --grep "Linux ${KERNEL}" --pretty=oneline | head -1)"
  [ -z "${BASEREV}" ] && { echo "Unable to determine base revision for BRANCH=${BRANCH}, KERNEL=${KERNEL}"; exit 1; }

  echo
  echo "FOUND BASE REV: ${BASEREV}"
  echo

  BASEREV="${BASEREV%% *}"
fi

GIT_SEQUENCE_EDITOR=${BIN}/rpi-linux-rebase.sh git rebase -i ${BASEREV}
git format-patch --no-signature --stdout ${BASEREV} > /tmp/linux-01-RPi_support.patch

cd .. && rm -fr raspberrypi-linux

echo
cat /tmp/dropped

echo
echo "Dropped patches: /tmp/dropped"
echo "New patch file : /tmp/linux-01-RPi_support.patch"

echo
echo "## LibreELEC Update Notes ##"
echo
echo "cd LibreELEC.tv"
echo "git checkout master"
echo "git pull upstream master"
echo "git checkout -b somebranch"

echo
echo "cp /tmp/linux-01-RPi_support.patch projects/RPi/patches/linux/linux-01-RPi_support.patch"
echo
echo "cp /tmp/linux-01-RPi_support.patch projects/RPi2/patches/linux/linux-01-RPi_support.patch"

echo
echo "git commit -am \"RPi/RPi2: update linux support patches for linux ${KERNEL:-${BRANCH}}\""

echo
