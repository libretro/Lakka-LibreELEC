# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-beetle-gba"
PKG_VERSION="f41ee5c"
PKG_SHA256="4581f580dd25b293587f5226f08c4a05d91ea04c7500812ead986995e7b617d1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-gba-libretro"
PKG_URL="https://github.com/libretro/beetle-gba-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="beetle-gba-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.beetle-gba: Beetle GBA for Kodi"
PKG_LONGDESC="game.libretro.beetle-gba: Beetle GBA for Kodi"

PKG_LIBNAME="mednafen_gba_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="BEETLE-GBA_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
