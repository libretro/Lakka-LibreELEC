# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mesen"
PKG_VERSION="b8acf5b7b840d37abc38b730b781be1d83afca66"
PKG_SHA256="42ac4c26bfab27d65c540df50001a93b5aa9b381d1db78bdece93fcbfb8331e9"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/SourMesen/Mesen/"
PKG_URL="https://github.com/SourMesen/Mesen/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.mesen: mesen for Kodi"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mesen_libretro.so"
PKG_LIBPATH="Libretro/${PKG_LIBNAME}"
PKG_LIBVAR="MESEN_LIB"

make_target() {
  make -C Libretro/
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
