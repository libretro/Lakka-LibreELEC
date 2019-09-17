# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-gambatte"
PKG_VERSION="4d9ad7b29946ec0a914b2d6a735b6c2704ed1f23"
PKG_SHA256="23faf0d690af53378e646cac2dcdf546b891fbbaab23d15992ecf30dca6433d5"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/gambatte-libretro"
PKG_URL="https://github.com/libretro/gambatte-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.gambatte: Gambatte for Kodi"

PKG_LIBNAME="gambatte_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="GAMBATTE_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
