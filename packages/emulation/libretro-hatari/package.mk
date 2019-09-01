# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-hatari"
PKG_VERSION="3fdaff4dce22c6a328fce932dc6ebcb30ff76dff"
PKG_SHA256="3df972f2ad5f46ded6588dd1b67d153681309ef77714314b629ab5406dd333ae"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/hatari"
PKG_URL="https://github.com/libretro/hatari/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
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
