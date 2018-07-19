# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-bsnes-mercury-performance"
PKG_VERSION="b626037"
PKG_SHA256="a07a5e4a5f7f39743c88ac841603832629dd12ce37b9ea361a45958b667d5699"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/bsnes-mercury"
PKG_URL="https://github.com/libretro/bsnes-mercury/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="bsnes-mercury-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.beetle-bsnes-performance: Beetle bSNES for Kodi"
PKG_LONGDESC="game.libretro.beetle-bsnes-performance: Beetle bSNES for Kodi"

PKG_LIBNAME="bsnes_mercury_performance_libretro.so"
PKG_LIBPATH="out/$PKG_LIBNAME"
PKG_LIBVAR="BSNES-MERCURY-PERFORMANCE_LIB"

make_target() {
  make profile=performance
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
