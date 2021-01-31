# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mgba"
PKG_VERSION="0d826c9307bef16ff54468986173162acaafdf70"
PKG_SHA256="f3bdf33b0864b989aba247d8b19476cf3e7291464d8bdfcc0027e974c5675945"
PKG_LICENSE="MPL 2.0"
PKG_SITE="https://github.com/libretro/mgba"
PKG_URL="https://github.com/libretro/mgba/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform zlib"
PKG_LONGDESC="game.libretro.mgba: mGBA for Kodi"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mgba_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MGBA_LIB"

pre_configure_target() {
  # fails to build in subdirs
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}
}

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
