# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-fceumm"
PKG_VERSION="0d569e9bab054f215f828184c1d63fa69f8abd0c"
PKG_SHA256="1aae47c75abaf3d5a8e1250498956abc484cfcfbfec111ebadb46cbec63df36e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-fceumm"
PKG_URL="https://github.com/libretro/libretro-fceumm/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.fceumm: FCEUmm emulator for Kodi"

PKG_LIBNAME="fceumm_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="FCEUMM_LIB"

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
