# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-fmsx"
PKG_VERSION="3de916bbf15062de1ab322432d38a1fee29d5e68"
PKG_SHA256="3947737df79a97be2dd156420a3951f4424d7a51e68a7cacc661ee3e2fa1d767"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/fmsx-libretro"
PKG_URL="https://github.com/libretro/fmsx-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.fmsx: fmsx for Kodi"

PKG_LIBNAME="fmsx_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="FMSX_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
