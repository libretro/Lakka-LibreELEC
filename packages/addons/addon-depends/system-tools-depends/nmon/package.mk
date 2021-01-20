# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nmon"
PKG_VERSION="16m" # 25 Sep 2019
PKG_SHA256="2bed4d45fdfdf1d1387ec91e139c04975d5f838e3e0d53c0fe2d803a707e5fc1"
PKG_LICENSE="GPL"
PKG_SITE="http://nmon.sourceforge.net/pmwiki.php?n=Site.CompilingNmon"
PKG_URL="http://sourceforge.net/projects/nmon/files/lmon16m.c"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="Systems administrator, tuner, benchmark tool gives you a huge amount of important performance information in one go."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-sysroot"

unpack() {
  mkdir -p ${PKG_BUILD}
  cp -p ${SOURCES}/nmon/${PKG_SOURCE_NAME} ${PKG_BUILD}
}

make_target() {
  case ${ARCH} in
    x86_64)
      arch="X86"
      ;;
    *)
      arch="arm"
      ;;
  esac
  # original makefile is located at
  # - https://downloads.sourceforge.net/project/nmon/makefile
  CFLAGS+=" -g -O3 -Wall -D JFS -D GETUSER -D LARGEMEM"
  LDFLAGS+=" -lncurses -lm -g"
  ${CC} -o nmon nmon-${PKG_VERSION}.c ${CFLAGS} ${LDFLAGS} -D ${arch} -DUBUNTU
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -p nmon ${INSTALL}/usr/bin
}
