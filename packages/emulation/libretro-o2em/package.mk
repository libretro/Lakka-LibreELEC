# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-o2em"
PKG_VERSION="51e5e19d71c5c17d87ce67a5faf60a8b77d40135"
PKG_SHA256="de7b3e61ba978d7d793d3458002c3e247961d3dbbb91f406ce798b873c311cba"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-o2em"
PKG_URL="https://github.com/libretro/libretro-o2em/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.o2em: o2em for Kodi"

PKG_LIBNAME="o2em_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="O2EM_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
