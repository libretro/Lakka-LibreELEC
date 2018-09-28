# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-hatari"
PKG_VERSION="86a8307e14946ae495456e7aa81af4e39de307d9"
PKG_SHA256="1774e69ad96e86dec487428369a42eadec0d9653f5cb7c4b7fd2e66428f8bd6c"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/hatari"
PKG_URL="https://github.com/libretro/hatari/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="hatari-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.hatari: hatari for Kodi"
PKG_LONGDESC="game.libretro.hatari: hatari for Kodi"
PKG_TOOLCHAIN="manual"

PKG_LIBNAME="hatari_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="HATARI_LIB"

make_target() {
  cd $PKG_BUILD
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
