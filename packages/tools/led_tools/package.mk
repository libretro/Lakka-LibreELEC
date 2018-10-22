# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2014 Gordon Hollingworth (gordon@fiveninjas.com)

PKG_NAME="led_tools"
PKG_VERSION="0.1"
PKG_SHA256="0484b4a2da9d586accef87ba7dd18595baae1d602c1b1bd9e0a8565ab50419a2"
PKG_LICENSE="GPL"
PKG_SITE="http://www.fiveninjas.com"
PKG_URL="http://updates.fiveninjas.com/src/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib libpng slice-addon"
PKG_DEPENDS_HOST="toolchain"
PKG_LONGDESC="LED tools, these are a set of tools to control the LEDs on Slice"

make_target() {
  make CC="$CC" \
       CFLAGS="$CFLAGS" \
       LDFLAGS="$LDFLAGS"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp led_png $INSTALL/usr/bin
}
