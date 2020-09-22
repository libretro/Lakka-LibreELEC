# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-beetle-psx"
PKG_VERSION="1e6f9b53ee964188fb8932745b75815636f20e41"
PKG_SHA256="8ee59b59819c6b6e86b38c55233ee805010b8b0866d2f8c9e775b026db056ac4"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-psx-libretro"
PKG_URL="https://github.com/libretro/beetle-psx-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Fork of Mednafen PSX"

PKG_LIBNAME="mednafen_psx_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="BEETLE-PSX_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
