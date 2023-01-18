# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-bsnes-mercury-accuracy"
PKG_VERSION="4ba6d8d88e57d3193d95e1bcf39e8d31121f76d4"
PKG_SHA256="7c0c84fe83c5b0dabcc35cf0195e2e54e5a17a828e40d95cd726ab3979589139"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/bsnes-mercury"
PKG_URL="https://github.com/libretro/bsnes-mercury/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.beetle-bsnes-accuracy: Beetle bSNES for Kodi"

PKG_LIBNAME="bsnes_mercury_accuracy_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="BSNES-MERCURY-ACCURACY_LIB"

make_target() {
  make PROFILE=accuracy
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
