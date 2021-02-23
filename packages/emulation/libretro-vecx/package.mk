# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vecx"
PKG_VERSION="98bd64b66923f4fc93eb6831f79c4119150bbe80"
PKG_SHA256="75bec727d962db5a7ea2425252a905f69d1c14dd93cdbae134d633b2e080721c"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-vecx"
PKG_URL="https://github.com/libretro/libretro-vecx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.vecx: vecx for Kodi"

PKG_LIBNAME="vecx_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="VECX_LIB"

make_target() {
  if [ "${OPENGL_SUPPORT}" = no ]; then
    HAS_GLES=1 make
  else
    make
  fi
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
