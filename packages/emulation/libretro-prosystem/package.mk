# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-prosystem"
PKG_VERSION="fbf62c3dacaac694f7ec26cf9be10a51b27271e7"
PKG_SHA256="01f8675b0d15a606b44f879cc481fbf17f422ab57c14fce292726b5932fdc7dc"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/prosystem-libretro"
PKG_URL="https://github.com/libretro/prosystem-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Port of ProSystem to libretro"

PKG_LIBNAME="prosystem_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="PROSYSTEM_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
