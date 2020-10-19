# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-scummvm"
PKG_VERSION="7b1e9299057a01a1defad6dbae4bdbeed36aa767"
PKG_SHA256="a2dd4c2913c88fd2f0f1ef8eb5d84734d86c3a73313e734380a95ae6b8e2de9b"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/scummvm"
PKG_URL="https://github.com/libretro/scummvm/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.scummvm: scummvm for Kodi"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="scummvm_libretro.so"
PKG_LIBPATH="backends/platform/libretro/build/$PKG_LIBNAME"
PKG_LIBVAR="SCUMMVM_LIB"

PKG_MAKE_OPTS_TARGET="-C backends/platform/libretro/build/"

pre_make_target() {
  cd $PKG_BUILD
  CXXFLAGS+=" -DHAVE_POSIX_MEMALIGN=1"
  export AR+=" cru"
  export LD="$CC"
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
