# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-tgbdual"
PKG_VERSION="b1fd9280dc89733ecdfb45d7d24b65e5e30f74a5"
PKG_SHA256="246dd68382a6b87be3001decbfef4c4ba6e9b209948ec22c7cf3ba94a5ddfd2f"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/tgbdual-libretro"
PKG_URL="https://github.com/libretro/tgbdual-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.tgbdual: tgbdual for Kodi"

PKG_LIBNAME="tgbdual_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="TGBDUAL_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
