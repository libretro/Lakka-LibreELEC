# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="edid-decode"
PKG_VERSION="f56f329"
PKG_SHA256="d9347ddf6933c6f90c79230b1898da5686083f0e5ebb7ef67acb011108cfaeae"
PKG_LICENSE="None"
PKG_SITE="https://cgit.freedesktop.org/xorg/app/edid-decode/"
PKG_URL="https://cgit.freedesktop.org/xorg/app/edid-decode/snapshot/$PKG_VERSION.tar.xz"
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
