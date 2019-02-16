# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-dinothawr"
PKG_VERSION="387d6128ffedadefaf60eae5cf9037123f185abf"
PKG_SHA256="fd8088386cab23d9b2636d6dbb9a20818432b721d258942e1e6c7a9c689ce94e"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/Dinothawr"
PKG_URL="https://github.com/libretro/Dinothawr/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.dinothawr: dinothawr for Kodi"

PKG_LIBNAME="dinothawr_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="DINOTHAWR_LIB"

pre_make_target() {
  if target_has_feature neon; then
    export HAVE_NEON=1
  fi
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
