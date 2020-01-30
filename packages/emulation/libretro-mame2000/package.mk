# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2000"
PKG_VERSION="e5d4a934c60adc6d42a3f87319312aad89595a15"
PKG_SHA256="64fc5f84cca91a2761c771fdd3c8d359eea4f24cbbcb00bf53cb4cbc6f42560e"
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
