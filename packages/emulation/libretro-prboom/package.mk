# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-prboom"
PKG_VERSION="b22a6b19fd976a14374db9083baea9c91b079106"
PKG_SHA256="5f3eca09027d86b10836db6b35d552268aee756735a80738f39f07ce118acb25"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-prboom"
PKG_URL="https://github.com/libretro/libretro-prboom/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.prboom: prboom for Kodi"

PKG_LIBNAME="prboom_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="PRBOOM_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
