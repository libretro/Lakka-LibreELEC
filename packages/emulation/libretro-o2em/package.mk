# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-o2em"
PKG_VERSION="c1f5b42f02bc485d504f2c5198d27148fb71b5bc"
PKG_SHA256="c63cce853e761a4387d57f8d5b7a4b0ec431469d9c471e4b77cdb0fd1193951c"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-o2em"
PKG_URL="https://github.com/libretro/libretro-o2em/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.o2em: o2em for Kodi"

PKG_LIBNAME="o2em_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="O2EM_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
