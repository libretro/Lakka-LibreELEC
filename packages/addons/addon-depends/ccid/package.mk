# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ccid"
PKG_VERSION="1.7.1"
PKG_SHA256="32799ab16fe6e493c9452be3823f21810fbe80b884021a6f6f3fa69f26be5c86"
PKG_LICENSE="LGPL"
PKG_SITE="https://ccid.apdu.fr"
PKG_URL="https://ccid.apdu.fr/files/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain pcsc-lite"
PKG_LONGDESC="A generic USB Chip/Smart Card Interface Devices driver."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --enable-twinserial"

post_configure_target() {
  libtool_remove_rpath libtool
}

make_target() {
  make
  make -C src/ Info.plist
}
