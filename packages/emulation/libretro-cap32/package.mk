# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-cap32"
PKG_VERSION="23a8b5d3f664148660f759d1463c36fef7a79019"
PKG_SHA256="0f6e13bae1ac65e9853dfdacf62b90fdf525421ac728a5d71d3b6b159c4b95b7"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-cap32"
PKG_URL="https://github.com/libretro/libretro-cap32/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.cap32: cap32 for Kodi"

PKG_LIBNAME="cap32_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="CAP32_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
