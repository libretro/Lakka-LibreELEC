#!/bin/bash
set -e

BIN=$(readlink -f $(dirname $0))

if git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "Don't run this script inside a git reppository!"
  exit 1
fi

DEPTH=1000
BRANCH="$1"

while [ $# -gt 1 ]; do
  if [ "${2,,}" == "rebase" ]; then
    REBASE="_rebase"
  elif [[ ${2,,} =~ [_-]rebase ]]; then
    REBASE="$2"
  elif [[ ${2} =~ ^[0-9a-f]*$ ]]; then
    BASEREV="${2}"
  fi
  shift
done

usage()
{
  local me="$(basename $0)"

  echo "Usage:   ${me} <major.minor>|<major.minor.patch> [[_-]rebase] [baserev]"
  echo
  echo "Example: 4.4 (for rpi-4.4.y) or 4.4.6 - specifying an exact kernel version avoids fetching the upstream repo"
  echo "         4.4 rebase  - use rpi-4.4.y_rebase branch"
  echo "         4.4 -rebase  - use rpi-4.4.y-rebase branch"
  echo "         4.6-rc6"
  echo "         4.7 523d939ef98fd712632d93a5a2b588e477a7565e"
  echo "         4.7.0"
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

# On initial release, eg. 4.7.0, the kernel will actually be known as 4.7 in git so strip the trailing .0
[[ ${KERNEL} =~ ^[0-9]*\.[0-9]*\.0*$ ]] && KERNEL="${KERNEL%.*}"

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

if [ -z "${KERNEL}" -a -z "${BASEREV}" ]; then
  git remote add -t linux-${BRANCH}.y linux-stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
fi

# Apply the following config change to reduce chance of duplicate hashes
git config --local core.abbrev 40 

git fetch --all --depth=${DEPTH} --no-tags
git reset --hard origin/rpi-${BRANCH}.y${REBASE}

if [ -n "${BASEREV}" ]; then
  :
elif [ -z "${KERNEL}" ]; then
  BASEREV="linux-stable/linux-${BRANCH}.y"
  KERNEL="$(git log --grep "Linux ${BRANCH}" --pretty=oneline | head -1 | awk '{ print $NF }')"
else
  BASEREV="$(git log --grep "Linux ${KERNEL}" --pretty=oneline | head -1)"
  [ -z "${BASEREV}" ] && BASEREV="$(git log --grep "Linux v${KERNEL}" --pretty=oneline | head -1)"
  [ -z "${BASEREV}" ] && { echo "Unable to determine base revision for BRANCH=${BRANCH}, KERNEL=${KERNEL}"; exit 1; }

  echo
  echo "FOUND BASE REV: ${BASEREV}"
  echo

  BASEREV="${BASEREV%% *}"
fi

GIT_SEQUENCE_EDITOR=${BIN}/rpi-linux-rebase.sh git rebase -Xours -i ${BASEREV}
git format-patch --no-signature --stdout ${BASEREV} > /tmp/linux-01-RPi_support.patch

cd .. && rm -fr raspberrypi-linux

echo
cat /tmp/dropped

echo
echo "Dropped patches: /tmp/dropped"

LINE_START=$(grep -n '^DROP_COMMITS="$' ${BIN}/rpi-linux-rebase.sh | awk -F: '{print $1}')
LINE_END=$(grep -n '^"$' ${BIN}/rpi-linux-rebase.sh | awk -F: '{print $1}')
while read -r msg; do
 grep -qxE "drop [a-f0-9]{40} ${msg}$" /tmp/dropped || LINES+="${msg}\n"
done <<< "$(sed -n "$((LINE_START + 1)),$((LINE_END - 1))p" ${BIN}/rpi-linux-rebase.sh | grep -v "^#### " | tr -d "\\\\")"

[ -n "${LINES}" ] && echo -e "*****\nThe following commits are no longer being dropped:\n\n${LINES}*****"

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
echo "git commit -am \"RPi: update linux support patch for linux ${KERNEL:-${BRANCH}}\""

echo
