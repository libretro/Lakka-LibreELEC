# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="edid-decode"
PKG_VERSION="15df4aebf06da579241c58949493b866139d0e2b"
PKG_SHA256="58743c8ba768134ef1421e1ce9f4edf0eafdae29377fe5b8f4cb285f16dc142e"
PKG_LICENSE="None"
PKG_SITE="https://git.linuxtv.org/edid-decode.git/"
PKG_URL="https://git.linuxtv.org/edid-decode.git/snapshot/$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Decode EDID data in human-readable format"

make_target() {
  echo "$CC $CFLAGS -Wall $LDFLAGS -lm -o edid-decode edid-decode.c"
  $CC $CFLAGS -Wall $LDFLAGS -lm -o edid-decode edid-decode.c
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp edid-decode $INSTALL/usr/bin
}
