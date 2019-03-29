# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-bnes"
PKG_VERSION="598c123771c885f8c48967f82b3a496b9e105b79"
PKG_SHA256="6e8d04517908593c7c3260d5358da4de0caffeb9dd5457b0097555a144f4c757"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/bnes-libretro"
PKG_URL="https://github.com/libretro/bnes-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.bnes: bNES for Kodi"

PKG_LIBNAME="bnes_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="BNES_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
