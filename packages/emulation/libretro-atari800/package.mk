# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-atari800"
PKG_VERSION="8ce851fbca0d360763a267322f6a76c3c80ddae6"
PKG_SHA256="4a1b17cbdb606dbc444984a70753b98797a7b4634e4c9fea998e5db08ee25ba6"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-atari800"
PKG_URL="https://github.com/libretro/libretro-atari800/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Atari 8-bit computer and 5200 console emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="platform=unix"

PKG_LIBNAME="atari800_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="ATARI800_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
