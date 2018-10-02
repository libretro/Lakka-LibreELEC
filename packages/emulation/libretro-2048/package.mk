# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-2048"
PKG_VERSION="82843002384e8d9b495f80acdee8bdf0e2bde74c"
PKG_SHA256="1676cdf0479b31b0827ce9eac54630493b7dc76b007716f24b4fb5bde12ec858"
PKG_ARCH="any"
PKG_LICENSE="Public domain"
PKG_SITE="https://github.com/libretro/libretro-2048"
PKG_URL="https://github.com/libretro/libretro-2048/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="libretro-2048-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.2048: 2048 for Kodi"
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
