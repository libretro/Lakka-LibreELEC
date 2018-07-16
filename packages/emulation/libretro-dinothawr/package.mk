# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-dinothawr"
PKG_VERSION="92431d1"
PKG_SHA256="93f31617fbed6274efc312c056d64018cc3d42a0302ea583950ec41cb788c05c"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/Dinothawr"
PKG_URL="https://github.com/libretro/Dinothawr/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="Dinothawr-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.dinothawr: dinothawr for Kodi"
PKG_LONGDESC="game.libretro.dinothawr: dinothawr for Kodi"

PKG_LIBNAME="dinothawr_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="DINOTHAWR_LIB"

pre_make_target() {
  if target_has_feature neon; then
    export HAVE_NEON=1
  fi
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
