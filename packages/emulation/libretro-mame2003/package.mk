# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2003"
PKG_VERSION="a1962287e121698ddc43c70a3472b2a420a58d8f"
PKG_SHA256="0e9cd21c20d847714cfd6b1899d9a18b42ac13ba52732366aace399ba343bce1"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2003-libretro"
PKG_URL="https://github.com/libretro/mame2003-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
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
