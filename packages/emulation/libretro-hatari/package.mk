# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-hatari"
PKG_VERSION="ec1b59c4b6c7ca7d0d23d60cfe2cb61911b11173"
PKG_SHA256="4deea8ba40e7ce026db731b511e01bea5caa5a51b3499aa4473405841cbedd67"
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
