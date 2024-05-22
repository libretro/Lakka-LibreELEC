# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-atari800"
PKG_VERSION="8bfa3b80f6a2db365dfd1e8a6c06b7b0844327cf"
PKG_SHA256="c1fee7ff0a87ff2ca1dc1d9ace1bb3a66615a299c0f4e796e75ba97c680852bb"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-atari800"
PKG_URL="https://github.com/libretro/libretro-atari800/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro port of Atari800 emulator version 3.1.0"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="atari800_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="ATARI800_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
