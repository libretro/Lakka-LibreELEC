# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-bluemsx"
PKG_VERSION="b75da4e3394fd3c956a09958a97b67bc6db79f4d"
PKG_SHA256="29da5922f5e5f1ad3e3d3ff4c9fb1d4cfa15e08a53b309027ce42977b8d76805"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/blueMSX-libretro"
PKG_URL="https://github.com/libretro/blueMSX-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.bluemsx: BlueMSX for Kodi"

PKG_LIBNAME="bluemsx_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="BLUEMSX_LIB"

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
