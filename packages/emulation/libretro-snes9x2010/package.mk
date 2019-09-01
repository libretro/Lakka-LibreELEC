# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-snes9x2010"
PKG_VERSION="b6d4b2fac07f6903c358c0bdf4b0a75c452575d6"
PKG_SHA256="3f908246a1b3d72aec95cf106e54330325adccb146b0fb7524fcfdb3f09a064a"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/snes9x2010"
PKG_URL="https://github.com/libretro/snes9x2010/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="snes9x2010 for Kodi"

PKG_LIBNAME="snes9x2010_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="SNES9X2010_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
