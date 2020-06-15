# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-tyrquake"
PKG_VERSION="8c6ec56b95860726ab8faae0356751adb90f395c"
PKG_SHA256="1faf0c37a8b56b61b0de3955e4664136709060f5e81416e2b7db905392bfe8b6"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/tyrquake"
PKG_URL="https://github.com/libretro/tyrquake/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
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
