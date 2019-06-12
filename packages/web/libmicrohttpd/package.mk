# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libmicrohttpd"
PKG_VERSION="0.9.63"
PKG_SHA256="37c36f1be177f0e37ef181a645cd3baac1000bd322a01c2eff70f3cc8c91749c"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="http://www.gnu.org/software/libmicrohttpd/"
PKG_URL="http://ftpmirror.gnu.org/libmicrohttpd/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A small C library that is supposed to make it easy to run an HTTP server as part of another application."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --disable-curl \
                           --disable-https \
                           --with-libgcrypt-prefix=$SYSROOT_PREFIX/usr"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
