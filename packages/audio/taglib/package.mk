# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="taglib"
PKG_VERSION="1.11.1"
PKG_SHA256="b6d1a5a610aae6ff39d93de5efd0fdc787aa9e9dc1e7026fa4c961b26563526b"
PKG_LICENSE="LGPL"
PKG_SITE="http://taglib.github.com/"
PKG_URL="http://taglib.github.io/releases/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host zlib"
PKG_LONGDESC="TagLib is a library for reading and editing the meta-data of several popular audio formats."

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DWITH_MP4=ON \
                       -DWITH_ASF=ON"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  # pkgconf hack
  sed -e "s:\(['=\" ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" -i $SYSROOT_PREFIX/usr/bin/taglib-config
  sed -e "s:\([':\" ]\)-I/usr:\\1-I$SYSROOT_PREFIX/usr:g" -i $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib.pc
  sed -e "s:\([':\" ]\)-L/usr:\\1-L$SYSROOT_PREFIX/usr:g" -i $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib.pc
  sed -e "s:\([':\" ]\)-I/usr:\\1-I$SYSROOT_PREFIX/usr:g" -i $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib_c.pc
  sed -e "s:\([':\" ]\)-L/usr:\\1-L$SYSROOT_PREFIX/usr:g" -i $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib_c.pc
}
