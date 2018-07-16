# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2003"
PKG_VERSION="69163cc"
PKG_SHA256="5c505590857319cfb7043883afa1965067bfa8387829ff6cbe462927f1262303"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2003-libretro"
PKG_URL="https://github.com/libretro/mame2003-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="mame2003-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="Late 2003 version of MAME (0.78) for libretro"
PKG_LONGDESC="Late 2003 version of MAME (0.78) for libretro"

PKG_LIBNAME="mame2003_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MAME2003_LIB"

configure_target() {
  export LD="$CC"
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
