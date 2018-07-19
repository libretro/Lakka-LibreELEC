# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-beetle-bsnes"
PKG_VERSION="1412023"
PKG_SHA256="07445d202c658337754682cc9453d96e95789f6606bd75c9e4b2686267333546"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-bsnes-libretro"
PKG_URL="https://github.com/libretro/beetle-bsnes-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="beetle-bsnes-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.beetle-bsnes: Beetle bSNES for Kodi"
PKG_LONGDESC="game.libretro.beetle-bsnes: Beetle bSNES for Kodi"

PKG_LIBNAME="mednafen_snes_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="BEETLE-BSNES_LIB"

make_target() {
  LDFLAGS="$LDFLAGS -ldl"
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
