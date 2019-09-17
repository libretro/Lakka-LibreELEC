# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mrboom"
PKG_VERSION="d6a1a24b7e47eba1c7b29d3d48d3148b54e1fbf8"
PKG_SHA256="07f580bc441e6530e819565a43d0d3a25f34726e32c67d939213dcc6254221ee"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/mrboom-libretro"
PKG_URL="https://github.com/libretro/mrboom-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.mrboom: mrboom for Kodi"

PKG_LIBNAME="mrboom_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MRBOOM_LIB"

pre_make_target() {
  # Disable NEON otherwise build fails
  if target_has_feature neon; then
    CFLAGS+=" -DDONT_WANT_ARM_OPTIMIZATIONS"
  fi
}

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
