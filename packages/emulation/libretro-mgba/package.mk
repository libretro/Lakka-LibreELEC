# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mgba"
PKG_VERSION="d98de4a"
PKG_SHA256="cca97b095137a3ad43915776d535960b6cbcbbf5e0da54d371a638c747f5aae8"
PKG_ARCH="any"
PKG_LICENSE="MPL 2.0"
PKG_SITE="https://github.com/libretro/mgba"
PKG_URL="https://github.com/libretro/mgba/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="mgba-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform libepoxy libzip SDL2"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.mgba: mGBA for Kodi"
PKG_LONGDESC="game.libretro.mgba: mGBA for Kodi"

PKG_LIBNAME="mgba_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MGBA_LIB"

pre_configure_target() {
  # fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
}

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
