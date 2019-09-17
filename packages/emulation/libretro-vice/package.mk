# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vice"
PKG_VERSION="a7fc07ec0377fc85749067a33d3034036eb281ff"
PKG_SHA256="c31077cfa16553f53b552c5d378fadf8a9c5517efabfe841ee14c25b468caf69"
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
