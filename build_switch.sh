#!/bin/bash

cd "$(dirname "$0")"
unset CI

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

export DISTRO="Lakka"
export PROJECT="Switch"
export ARCH="aarch64"
export DEVICE="L4T"

if [ -d "$PROJECT_DIR/target" ]; then
  rm -rf "$PROJECT_DIR/target"
fi

build_target() {
  cd "$PROJECT_DIR"
  make image MAKEFLAGS=-j18
}

LOGFILE="$(mktemp)"
build_target 2> >(tee "$LOGFILE" >&2)
RC=${PIPESTATUS[0]}
if [[ $RC != 0 ]]; then
  if grep -qF 'cp: cannot stat' "$LOGFILE"; then
    echo "*** Kernel forced rebuild; trying again ***"
    build_target
    RC=$?
  fi
fi

if [ "$RC" -eq "0" ]; then
   exit 0
fi

exit 1
