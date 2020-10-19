# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-prosystem"
PKG_VERSION="95f2094b915afb502f74d921aceaf7db7e63a01c"
PKG_SHA256="3a9950d87c63b1ff98f168bff99bde037b49a49dfc03d9c5ebd3e56fb701e889"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/prosystem-libretro"
PKG_URL="https://github.com/libretro/prosystem-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Port of ProSystem to libretro"

PKG_LIBNAME="prosystem_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="PROSYSTEM_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
