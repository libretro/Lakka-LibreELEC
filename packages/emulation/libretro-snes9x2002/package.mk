# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-snes9x2002"
PKG_VERSION="8b76b5301822d92545e8f62b07f774715b1a1e8b"
PKG_SHA256="ece983f8cc1719e8abb573f50b2d66fdd2f4f43724e157e645fd1b60c5597634"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/snes9x2002"
PKG_URL="https://github.com/libretro/snes9x2002/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Port of SNES9x 1.39 for libretro. Heavily optimized for ARM."

PKG_LIBNAME="snes9x2002_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="SNES9X2002_LIB"

pre_make_target() {
  export CFLAGS="$CFLAGS -std=gnu11"
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
