# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-fuse"
PKG_VERSION="69a44421bd82b7ed4b389b1f997e6d5153ea855c"
PKG_SHA256="bd505c92bc4753204b00a41f2f7f506577abd9b0be45b33a5048dd0266b191d5"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/fuse-libretro"
PKG_URL="https://github.com/libretro/fuse-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="fuse-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.fuse: fuse for Kodi"
PKG_LONGDESC="game.libretro.fuse: fuse for Kodi"

PKG_LIBNAME="fuse_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="FUSE_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
