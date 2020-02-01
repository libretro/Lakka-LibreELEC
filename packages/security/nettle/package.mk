# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nettle"
PKG_VERSION="3.5.1"
PKG_SHA256="75cca1998761b02e16f2db56da52992aef622bf55a3b45ec538bc2eedadc9419"
PKG_LICENSE="GPL2"
PKG_SITE="http://www.lysator.liu.se/~nisse/nettle"
PKG_URL="http://ftpmirror.gnu.org/gnu/nettle/nettle-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain gmp"
PKG_LONGDESC="A low-level cryptographic library."

PKG_CONFIGURE_OPTS_TARGET="--disable-documentation \
                           --disable-openssl"

if target_has_feature neon; then
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-arm-neon"
fi

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
