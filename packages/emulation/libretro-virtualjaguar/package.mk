# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-virtualjaguar"
PKG_VERSION="575371decc78b186273146126140268c3efb7ce4"
PKG_SHA256="110933269a6f6e607101399c8c70a9a990d3f0d9c2d53b9daab5ec398360f80e"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/virtualjaguar-libretro"
PKG_URL="https://github.com/libretro/virtualjaguar-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Port of Virtual Jaguar to Libretro"

PKG_LIBNAME="virtualjaguar_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="VIRTUALJAGUAR_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
