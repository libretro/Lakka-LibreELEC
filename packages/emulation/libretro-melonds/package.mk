# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-melonds"
PKG_VERSION="33d84661d7dd67eab4eabe47bf069406cd9d1fe8"
PKG_SHA256="ddd5155ef77c5b2079e4d0bccb44a036340327cf9aeb897a39fbf99e9903b720"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/melonds"
PKG_URL="https://github.com/libretro/melonds/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="libretro wrapper for melonDS DS emulator."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="melonds_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MELONDS_LIB"

configure_target() {
  cd $PKG_BUILD
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
