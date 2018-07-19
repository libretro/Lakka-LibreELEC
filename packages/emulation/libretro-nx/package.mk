# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-nx"
PKG_VERSION="4321bbc"
PKG_SHA256="4b485533aa9ea8f5aa9e85f251c272b63f8f6051febf8fb7304cfc9915dddce3"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/nxengine-libretro"
PKG_URL="https://github.com/libretro/nxengine-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="nxengine-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.nx: nx for Kodi"
PKG_LONGDESC="game.libretro.nx: nx for Kodi"

PKG_LIBNAME="nxengine_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="NX_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
