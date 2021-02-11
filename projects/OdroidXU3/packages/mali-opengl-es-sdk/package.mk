# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mali-opengl-es-sdk"
PKG_VERSION="2.4.4"
PKG_SHA256="2a737cd93b56af7aecace737fb11e4cd5b90a1518d2c07d32a0825fe06706501"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="https://developer.arm.com/products/software/mali-sdks/opengl-es/downloads"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/mali-sdk/v2.4.4/Mali_OpenGL_ES_SDK_v2.4.4.ef7d5a_Linux_x64.tar.gz"
PKG_SOURCE_DIR="Mali_OpenGL_ES_SDK_v2.4.4"
PKG_LONGDESC="Mali headers for Odroid-XU3/XU4"
PKG_TOOLCHAIN="manual"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR $PKG_BUILD/inc/* $SYSROOT_PREFIX/usr/include
    cp -PR $PKG_BUILD/simple_framework/inc/mali/* $SYSROOT_PREFIX/usr/include
}

