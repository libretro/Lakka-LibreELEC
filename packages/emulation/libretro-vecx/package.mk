# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vecx"
PKG_VERSION="141af284202c86ed0d4ce9030c76954a144287cf"
PKG_SHA256="8fc8055a4f55c42d352dd2d82d3775996f604ad101f8c4f3140c20108f3d1b92"
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
