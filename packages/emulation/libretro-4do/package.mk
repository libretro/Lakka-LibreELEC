# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-4do"
PKG_VERSION="901f15b"
PKG_SHA256="643168ad3a009315089f2d478b659300ea234517658e23d712648fd0236ba007"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/libretro/4do-libretro"
PKG_URL="https://github.com/libretro/4do-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="4do-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="emulation"
PKG_SHORTDESC="Port of 4DO/libfreedo to libretro."
PKG_LONGDESC="Port of 4DO/libfreedo to libretro."

PKG_LIBNAME="4do_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="4DO_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
