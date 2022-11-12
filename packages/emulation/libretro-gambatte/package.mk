# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-gambatte"
PKG_VERSION="c7929548d76a2d595e4212d82afb07f8575feae5"
PKG_SHA256="68f929d720d529f7c195890bff0c1a17f28da45194de1f4ae6b418c984cc405f"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/gambatte-libretro"
PKG_URL="https://github.com/libretro/gambatte-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.gambatte: Gambatte for Kodi"

PKG_LIBNAME="gambatte_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="GAMBATTE_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
