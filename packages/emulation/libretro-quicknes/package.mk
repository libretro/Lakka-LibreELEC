# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-quicknes"
PKG_VERSION="1b85b4cf209a337faf8038c21c1d64d5d916ddd9"
PKG_SHA256="8a782a643af23d9aeb17726e97bbf5c32d509989b6a138db939ff6b63ae710f4"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/QuickNES_Core"
PKG_URL="https://github.com/libretro/QuickNES_Core/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.quicknes: QuickNES for Kodi"

PKG_LIBNAME="quicknes_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="QUICKNES_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
