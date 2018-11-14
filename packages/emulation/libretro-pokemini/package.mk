# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-pokemini"
PKG_VERSION="75d57602bc95ab0036da76c6d7eafbd7d07d73b2"
PKG_SHA256="4799796b4ab4143128d5c91eef5dab6b6c0ab30b4bb7f6615bab65f29ef4e4ad"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/pokemini"
PKG_URL="https://github.com/libretro/pokemini/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="libretro wrapper for PokeMini emulator."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="pokemini_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="POKEMINI_LIB"

configure_target() {
  cd $PKG_BUILD
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
