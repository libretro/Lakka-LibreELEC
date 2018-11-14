# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vice"
PKG_VERSION="ce4524df3c4e93e25dd97a6586c24c5e40d30c60"
PKG_SHA256="04e2081f08cb68e0d107e8f7a0e689dd103187c2062374754d2da138393706dc"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vice-libretro"
PKG_URL="https://github.com/libretro/vice-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="VICE C64 libretro"

PKG_LIBNAME="vice_x64_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="VICE_LIB"

pre_build_target() {
  export GIT_VERSION=$PKG_VERSION
}

make_target() {
  make -f Makefile.libretro CC=$CC
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
