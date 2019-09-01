# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-tgbdual"
PKG_VERSION="240b0bfa67639089ed7a0a53d8c45901a79d1402"
PKG_SHA256="7f92bea9295e19dcb6bc038bd6a74cf3c499542d67c13b2f027f096507a36283"
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
