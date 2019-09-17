# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-genplus"
PKG_VERSION="a02ec8763e662bab6a2530dd308255f059b999ff"
PKG_SHA256="d90c709fdb3455a9afea25e1af2598ef35085492822751f354291a6c72baf1f2"
PKG_LICENSE="Modified BSD / LGPLv2.1"
PKG_SITE="https://github.com/libretro/Genesis-Plus-GX"
PKG_URL="https://github.com/libretro/Genesis-Plus-GX/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.genplus: Genesis Plus GX for Kodi"
PKG_TOOLCHAIN="manual"

PKG_LIBNAME="genesis_plus_gx_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="GENPLUS_LIB"

make_target() {
  if [ "$ARCH" = "arm" ]; then
    CFLAGS="$CFLAGS -DALIGN_LONG"
  fi

  make -f Makefile.libretro GIT_VERSION=$PKG_VERSION
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
