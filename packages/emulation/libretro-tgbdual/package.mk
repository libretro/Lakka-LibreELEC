# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-tgbdual"
PKG_VERSION="a7b8bb3a3faabcb2f449d3f65ab53357ec074d99"
PKG_SHA256="934d1df8d465ccb9c9df18d1ace0944e825cc048fb4d1e73e0dae0adf36f62ba"
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
