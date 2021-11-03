# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-fmsx"
PKG_VERSION="9c0f61dbe320a4e551784a74264b037208c36dba"
PKG_SHA256="48a42792e3ba04f2728a04613f3af9c5b1e859d6c3e9fa45748cdaed4a04f5ea"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/fmsx-libretro"
PKG_URL="https://github.com/libretro/fmsx-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.fmsx: fmsx for Kodi"

PKG_LIBNAME="fmsx_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="FMSX_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
