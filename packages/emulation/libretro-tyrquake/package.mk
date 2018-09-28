# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-tyrquake"
PKG_VERSION="7d18c405b3713577865d2bbb1a654b1ad0c3cd62"
PKG_SHA256="cb19180f50b767866d5f1d77de15797dda999400d5175c70cd6c104cea497339"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/tyrquake"
PKG_URL="https://github.com/libretro/tyrquake/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="tyrquake-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.tyrquake: tyrquake for Kodi"
PKG_LONGDESC="game.libretro.tyrquake: tyrquake for Kodi"

PKG_LIBNAME="tyrquake_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="TYRQUAKE_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
