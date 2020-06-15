# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2003_plus"
PKG_VERSION="0134c428b75882aa474f78dbbf2c6ecde49b97b7"
PKG_SHA256="ecd4e6be29eea975543590864ef06e177313c963e5274ec2622fbc1c57d50ef0"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2003-plus-libretro"
PKG_URL="https://github.com/libretro/mame2003-plus-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Updated 2018 version of MAME (0.78) with added game support plus many fixes and improvements"

PKG_LIBNAME="mame2003_plus_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MAME2003_PLUS_LIB"

configure_target() {
  export LD="$CC"
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
