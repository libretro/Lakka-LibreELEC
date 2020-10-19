# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-gambatte"
PKG_VERSION="de629ff9c932f423c1d088479d7f2fffe09083c5"
PKG_SHA256="e6ab54d967927308af839ca034b2a07a0d9543b04ac46fccd2b8ebf50daf1ee0"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/gambatte-libretro"
PKG_URL="https://github.com/libretro/gambatte-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.gambatte: Gambatte for Kodi"

PKG_LIBNAME="gambatte_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="GAMBATTE_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
