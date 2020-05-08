# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-beetle-ngp"
PKG_VERSION="6f15532b6ad17a2d5eb9dc8241d6af62416e796b"
PKG_SHA256="4b88ab57bac0d5d61a24c7f9d5aa193cd21a6feb3a95b2c54611b165b79f8c19"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-ngp-libretro"
PKG_URL="https://github.com/libretro/beetle-ngp-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Standalone port of Mednafen NGP to the libretro API, itself a fork of Neopop"

PKG_LIBNAME="mednafen_ngp_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="BEETLE-NGP_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
