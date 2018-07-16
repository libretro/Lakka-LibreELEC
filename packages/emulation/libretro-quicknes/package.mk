# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-quicknes"
PKG_VERSION="6d50e29"
PKG_SHA256="fcc9e87fc0f1192dcadf71c316e383f2400c0d29af0ed2b275aafffc14364cb3"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/QuickNES_Core"
PKG_URL="https://github.com/libretro/QuickNES_Core/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="QuickNES_Core-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.quicknes: QuickNES for Kodi"
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
