# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-uae"
PKG_VERSION="4e85b3df50dac612e4ea301dbb019b734b5ece6e"
PKG_SHA256="95e402199e26e83f7cfcf4e6c8e709054f2ca5d2b662800a4b85f3c3bce21988"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-uae"
PKG_URL="https://github.com/libretro/libretro-uae/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="libretro wrapper for UAE emulator."
PKG_BUILD_FLAGS="-lto"

PKG_LIBNAME="puae_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="UAE_LIB"

pre_configure_target() {
  CFLAGS="$CFLAGS -fcommon"
  if [ "$TARGET_ARCH" = "arm" ]; then
    CFLAGS="$CFLAGS -DARM -marm"
  fi
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
