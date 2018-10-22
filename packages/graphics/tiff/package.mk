# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tiff"
PKG_VERSION="4.0.9"
PKG_SHA256="6e7bdeec2c310734e734d19aae3a71ebe37a4d842e0e23dbb1b8921c0026cfcd"
PKG_LICENSE="OSS"
PKG_SITE="http://www.remotesensing.org/libtiff/"
PKG_URL="http://download.osgeo.org/libtiff/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo zlib"
PKG_LONGDESC="libtiff is a library for reading and writing TIFF files."
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-mdi \
                           --enable-cxx \
                           --with-jpeg-lib-dir=$SYSROOT_PREFIX/usr/lib \
                           --with-jpeg-include-dir=$SYSROOT_PREFIX/usr/include \
                           --without-x"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
