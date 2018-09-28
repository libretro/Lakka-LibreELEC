# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-snes9x"
PKG_VERSION="249b5cf9765c435177414ff6ca23ea2b6cb4c893"
PKG_SHA256="fd63a9f119f2b00340fbc610646e7b587b3362022771c54df47da0120211b915"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/snes9x"
PKG_URL="https://github.com/libretro/snes9x/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="snes9x-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.snes9x: snes9x for Kodi"
PKG_LONGDESC="game.libretro.snes9x: snes9x for Kodi"
PKG_TOOLCHAIN="manual"

PKG_LIBNAME="snes9x_libretro.so"
PKG_LIBPATH="libretro/$PKG_LIBNAME"
PKG_LIBVAR="SNES9X_LIB"

make_target() {
  make -C libretro/
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
