# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vba-next"
PKG_VERSION="15037175093511aab9a52e27f28989c6c6fdb674"
PKG_SHA256="e72c17f1bfd1dabe955a0b59d9d15ef5469a4f54c0527f4320a5572aed220248"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vba-next"
PKG_URL="https://github.com/libretro/vba-next/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.vba-next: VBA-Next for Kodi"

PKG_LIBNAME="vba_next_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="VBA-NEXT_LIB"

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
