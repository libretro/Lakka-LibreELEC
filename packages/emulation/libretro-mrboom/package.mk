# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mrboom"
PKG_VERSION="5.2"
PKG_SUBVER=".454d614"
PKG_SHA256="50e4fe4bc74b23ac441499c756c4575dfe9faab9e787a3ab942a856ac63cf10d"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/Javanaise/mrboom-libretro"
PKG_URL="https://github.com/Javanaise/mrboom-libretro/releases/download/${PKG_VERSION}/MrBoom-src-${PKG_VERSION}${PKG_SUBVER}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.mrboom: mrboom for Kodi"

PKG_LIBNAME="mrboom_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MRBOOM_LIB"

pre_make_target() {
  # Disable NEON otherwise build fails
  if target_has_feature neon; then
    CFLAGS+=" -DDONT_WANT_ARM_OPTIMIZATIONS"
  fi
}

make_target() {
  make
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
