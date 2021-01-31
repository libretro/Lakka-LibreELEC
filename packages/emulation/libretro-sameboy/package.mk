# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-sameboy"
PKG_VERSION="907cb965baa3ae6e60469ddfbd82798988fa2a9c"
PKG_SHA256="bf654725b146a74565f739154ca1d6a51b7e914487c073f850caf9c35ea6323c"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/sameboy"
PKG_URL="https://github.com/libretro/sameboy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="libretro wrapper for SameBoy emulator."

PKG_LIBNAME="sameboy_libretro.so"
PKG_LIBPATH="libretro/${PKG_LIBNAME}"
PKG_LIBVAR="SAMEBOY_LIB"

make_target() {
  make -C libretro
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
