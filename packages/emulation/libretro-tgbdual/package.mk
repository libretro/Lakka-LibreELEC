# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-tgbdual"
PKG_VERSION="f7a2e2d28b188ef15502b66bb552b5b67440ff5e"
PKG_SHA256="d15c211320dffb65a985eae7afd764e8ef1c532a0c10e7d9c3f4345ccfa6cb77"
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
