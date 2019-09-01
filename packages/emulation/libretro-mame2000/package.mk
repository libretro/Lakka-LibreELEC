# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2000"
PKG_VERSION="dfd6c396e69e2ae89f2f52f4afa991c74813d828"
PKG_SHA256="db8758e7cf9b5ef244629fc4d235c31bca3d5402fe5a38cea4f266ad10a59600"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2000-libretro"
PKG_URL="https://github.com/libretro/mame2000-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="2000 version of MAME (0.37b5) for libretro"

PKG_LIBNAME="mame2000_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MAME2000_LIB"

make_target() {
  if [ "$TARGET_ARCH" = "arm" ]; then
    make ARM=1
  else
    make
  fi
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
