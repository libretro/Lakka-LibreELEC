# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nmon"
PKG_VERSION="411b08f1c98bca8b24670fc2d9ee6325b4fcb3d2"
PKG_SHA256="aa88257728e820db10b1f04792dfcc1b8a483de51bfda70db016da016a4879a2"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/axibase/nmon"
PKG_URL="https://github.com/axibase/nmon/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="Systems administrator, tuner, benchmark tool gives you a huge amount of important performance information in one go."
PKG_TOOLCHAIN="manual"

make_target() {
  case $ARCH in
    x86_64)
      arch="X86"
      ;;
    *)
      arch="arm"
      ;;
  esac
  CFLAGS="$CFLAGS -g -O3 -Wall -D JFS -D GETUSER -D LARGEMEM"
  LDFLAGS="$LDFLAGS -lncurses -lm -g"
  $CC -o nmon lmon*.c $CFLAGS $LDFLAGS -D $arch -D KERNEL_2_6_18
}
