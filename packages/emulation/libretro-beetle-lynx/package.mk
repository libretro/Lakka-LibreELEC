# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-beetle-lynx"
PKG_VERSION="9e1de59736b28c8f0cbfe759e0480b19c3dc7bcb"
PKG_SHA256="9d769dcd98e82091c3a92f5fd3372cc3ac9ad16b2df796c221b8c445cc277c14"
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
