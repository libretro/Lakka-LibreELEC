# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-4do"
PKG_VERSION="e2ba1ebcbf6f210fcb8807ea43f57fe03c5a10ba"
PKG_SHA256="e7d691d26cabf03c141111b308a528567633568a653fd473d78616cba2444619"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/libretro/4do-libretro"
PKG_URL="https://github.com/libretro/4do-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of 4DO/libfreedo to libretro."

PKG_LIBNAME="4do_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="4DO_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
