# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-gw"
PKG_VERSION="ae06261"
PKG_SHA256="939fb6ad965eb184f8635252a54181a7b1f6654b383572edf61f2130546450af"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/gw-libretro"
PKG_URL="https://github.com/libretro/gw-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="gw-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.gw: gw for Kodi"
PKG_LONGDESC="game.libretro.gw: gw for Kodi"

PKG_LIBNAME="gw_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="GW_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
