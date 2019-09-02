# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-quicknes"
PKG_VERSION="2cb3becfbb00d3bb6bcbf85bd4a9bb01b0a4a0e2"
PKG_SHA256="e05124979723ef59cf2c02b998a399c4a911e4652dd9deb8986b7d49689a1207"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/QuickNES_Core"
PKG_URL="https://github.com/libretro/QuickNES_Core/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.quicknes: QuickNES for Kodi"

PKG_LIBNAME="quicknes_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="QUICKNES_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
