# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-beetle-bsnes"
PKG_VERSION="0d6221a5fca708b36fa090d1c261663910d1e67e"
PKG_SHA256="46a20d9c16f853deff45b61ec50ea312b0afb1e2c3aaa024e57cdc78a2ad79fe"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-bsnes-libretro"
PKG_URL="https://github.com/libretro/beetle-bsnes-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
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
