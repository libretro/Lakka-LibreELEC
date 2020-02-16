# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libmicrohttpd"
PKG_VERSION="0.9.70"
PKG_SHA256="90d0a3d396f96f9bc41eb0f7e8187796049285fabef82604acd4879590977307"
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
