# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libjpeg-turbo"
PKG_VERSION="2.0.4"
PKG_SHA256="7777c3c19762940cff42b3ba4d7cd5c52d1671b39a79532050c85efb99079064"
PKG_LICENSE="GPL"
PKG_SITE="https://libjpeg-turbo.org/"
PKG_URL="https://github.com/libjpeg-turbo/libjpeg-turbo/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A high-speed version of libjpeg for x86 and x86-64 processors which uses SIMD."
PKG_BUILD_FLAGS="+pic +pic:host"

PKG_CMAKE_OPTS_HOST="-DENABLE_STATIC=ON \
                     -DENABLE_SHARED=OFF \
                     -DWITH_JPEG8=ON \
                     -DWITH_SIMD=OFF"

PKG_CMAKE_OPTS_TARGET="-DENABLE_STATIC=ON \
                       -DENABLE_SHARED=OFF \
                       -DWITH_JPEG8=ON"

if target_has_feature "(neon|sse)"; then
  PKG_CMAKE_OPTS_TARGET+=" -DWITH_SIMD=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DWITH_SIMD=OFF"
fi

if [ $TARGET_ARCH = "x86_64" ]; then
  PKG_DEPENDS_HOST+=" nasm:host"
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
