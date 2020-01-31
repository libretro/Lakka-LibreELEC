# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mrboom"
PKG_VERSION="c777f1059c9a4b3fcefe6e2a19cfe9f81a13740b"
PKG_SHA256="ef29851278c2f2ba5f5dc8672088a585e1147b0dea5f6fcd4d9538ca8a516e42"
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
