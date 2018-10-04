#!/bin/bash
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

export DISTRO="Lakka"
export PROJECT="Switch"
export ARCH="arm"

build_target() {
  cd "$PROJECT_DIR" && make image $MAKE_OPTS
}

LOGFILE="$(mktemp)"
build_target 2> >(tee "$LOGFILE" >&2)
RC=${PIPESTATUS[0]}
if [[ $RC != 0 ]]; then
  if grep -qF 'fatal error: asm/barrier.h: No such file or directory' "$LOGFILE"; then
    echo "*** asm/barrier.h bug detected; deleting the linux build artifact ***"
    find "$PROJECT_DIR" -maxdepth 2 -type d -path "$PROJECT_DIR/build.$DISTRO-$PROJECT.$ARCH-*-devel/linux-*" -print -exec rm -rf {} \;
    build_target
    RC=$?
  fi
fi

exit $RC

