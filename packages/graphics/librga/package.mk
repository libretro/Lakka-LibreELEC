# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="librga"
PKG_VERSION="72e7764"
PKG_SHA256="5bef2427479778f99d3df2c336409ef6f3fa953cf832ad5a4f126f1ad74ace30"
PKG_SITE="https://github.com/rockchip-linux/linux-rga"
PKG_URL="$LAKKA_MIRROR/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="graphics"

PKG_TOOLCHAIN="manual"

configure_target() {
  :
}

make_target() {
  PROJECT_DIR="$PKG_BUILD" make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include/rga
  cp $PKG_BUILD/*.h $SYSROOT_PREFIX/usr/include/rga
  
  mkdir -p $SYSROOT_PREFIX/usr/lib
  cp $PKG_BUILD/lib/librga.so $SYSROOT_PREFIX/usr/lib
  
  mkdir -p $INSTALL/usr/lib
  cp $PKG_BUILD/lib/librga.so $INSTALL/usr/lib
}
