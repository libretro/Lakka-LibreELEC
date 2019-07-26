# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vecx"
PKG_VERSION="6780accf94a06d78b462b07ace2354cb19c1f173"
PKG_SHA256="5078b09ab0c2dc5e8491bf9f4769580ebe40b66bf2bce1cd37feffc2390d4874"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-vecx"
PKG_URL="https://github.com/libretro/libretro-vecx/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.vecx: vecx for Kodi"

PKG_LIBNAME="vecx_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="VECX_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
