# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-dinothawr"
PKG_VERSION="2b36dc9be44e96a30d6c30eed2ad5b3dde0a3eda"
PKG_SHA256="3711e5f22b2d858b240f0192dc45c5e10f8929164a2566b07c7ce776e214d9c4"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/Dinothawr"
PKG_URL="https://github.com/libretro/Dinothawr/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
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
