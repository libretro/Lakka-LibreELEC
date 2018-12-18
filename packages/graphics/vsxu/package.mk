# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vsxu"
PKG_VERSION="0.5.1"
PKG_SHA256="6707b230ba6cb28c5b19ec6163722b801dd30afed8f966b57e188761b4d54b8e"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://www.vsxu.com"
# repackaged from https://github.com/vovoid/vsxu/archive/$PKG_VERSION.tar.gz
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain $OPENGL libX11 glew glfw zlib libpng libjpeg-turbo freetype"
PKG_LONGDESC="an OpenGL-based programming environment to visualize music and create graphic effects"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=0 \
                       -DVSXU_STATIC=1 \
                       -DCMAKE_POSITION_INDEPENDENT_CODE=1 \
                       -DCMAKE_CXX_FLAGS=-I$SYSROOT_PREFIX/usr/include/freetype2"

pre_configure_target(){
  export LDFLAGS="$LDFLAGS -lX11"
}

post_makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/vsxu
  cp -PR $INSTALL/usr/lib/* $SYSROOT_PREFIX/usr/lib

  mkdir -p $SYSROOT_PREFIX/usr/include/
  cp -RP $INSTALL/usr/include/* $SYSROOT_PREFIX/usr/include

  mkdir -p $SYSROOT_PREFIX/usr/share/
    cp -RP $INSTALL/usr/share/vsxu $SYSROOT_PREFIX/usr/share
}
