# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-2048"
PKG_VERSION="c5e0df2a74c4e25657095db114d62c2cefac9f52"
PKG_SHA256="d73185fc25813dca2fbd232f987a2d03bfb5fa519c4efdd946345a10babd471f"
PKG_LICENSE="Public domain"
PKG_SITE="https://github.com/libretro/libretro-2048"
PKG_URL="https://github.com/libretro/libretro-2048/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.2048: 2048 for Kodi"

PKG_LIBNAME="2048_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="2048_LIB"

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
