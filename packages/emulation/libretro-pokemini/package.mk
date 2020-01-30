# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-pokemini"
PKG_VERSION="4f2a6a2e3009d14b2c25007544c5c6c47d2b3525"
PKG_SHA256="242b197f2126249fb6cfdc94a7f0f046ab06133bb88c2ecc947930b2f02a2f6a"
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
