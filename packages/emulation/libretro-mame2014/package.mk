# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2014"
PKG_VERSION="62a932c9435ef89fdb9a1b0c41deadd7f04f53f3"
PKG_SHA256="9b38e1c0d75bc4295d9c08288579f2bf58e55e97132308b65d92ca494e55fa67"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2014-libretro"
PKG_URL="https://github.com/libretro/mame2014-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Late 2014/Early 2015 version of MAME (0.159-ish) for libretro"

PKG_LIBNAME="mame2014_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MAME2014_LIB"

pre_make_target() {
  export REALCC=$CC
  export CC=$CXX
  export LD=$CXX
}

make_target() {
  case $TARGET_CPU in
    arm1176jzf-s)
      make platform=armv6-hardfloat-$TARGET_CPU
      ;;
    cortex-a7|cortex-a9)
      make platform=armv7-neon-hardfloat-$TARGET_CPU
      ;;
    *cortex-a53|cortex-a17)
      if [ "$TARGET_ARCH" = "aarch64" ]; then
        make platform=aarch64
      else
        make platform=armv7-neon-hardfloat-cortex-a9
      fi
      ;;
    x86-64)
      make
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
