# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-beetle-lynx"
PKG_VERSION="a43fa4792647cfb0a170d9c4b6aa2f3804f28c84"
PKG_SHA256="5506e309ea0fa9338317583dd4d04f8dedda50d049df07613a055fc5be7bc9a5"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-lynx-libretro"
PKG_URL="https://github.com/libretro/beetle-lynx-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Standalone port of Mednafen Lynx to libretro, itself a fork of Handy"

PKG_LIBNAME="mednafen_lynx_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="BEETLE-LYNX_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
