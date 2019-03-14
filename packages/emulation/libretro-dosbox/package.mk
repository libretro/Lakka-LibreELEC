# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-dosbox"
PKG_VERSION="7216efe33153f028573ad68a843d897bdb11a69c"
PKG_SHA256="ce4c6fd502c3fdbe8d6f32628c6bd572f0ce8ed253d80b50cfad39fba3e16693"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dosbox-libretro"
PKG_URL="https://github.com/libretro/dosbox-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.dosbox: DOSBox for Kodi"
PKG_BUILD_FLAGS="+pic"

PKG_LIBNAME="dosbox_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="DOSBOX_LIB"

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
