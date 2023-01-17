# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-cap32"
PKG_VERSION="b3160da5052f51dff7e02b3810296e2afe4cbf45"
PKG_SHA256="e9c329275ea732463f0bed03b2bfa016283326778c026cdfda389b28f1f87b71"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-cap32"
PKG_URL="https://github.com/libretro/libretro-cap32/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.cap32: cap32 for Kodi"

PKG_LIBNAME="cap32_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="CAP32_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
