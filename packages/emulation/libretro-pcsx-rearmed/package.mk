# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-pcsx-rearmed"
PKG_VERSION="0370856deb325e759179c6835897e2553cef31c2"
PKG_SHA256="e4971b2624100a4389e81ac51f2b43ab2784993e6803b47f8cdf7b96c86d8d8e"
PKG_ARCH="arm"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="https://github.com/libretro/pcsx_rearmed/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="pcsx_rearmed-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.pcsx-rearmed: PCSX Rearmed for Kodi"
PKG_LONGDESC="game.libretro.pcsx-rearmed: PCSX Rearmed for Kodi"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-gold"

PKG_LIBNAME="pcsx_rearmed_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="PCSX-REARMED_LIB"

make_target() {
  cd $PKG_BUILD
  
  if target_has_feature neon; then
    export HAVE_NEON=1
   else
    export HAVE_NEON=0
  fi
  
  case $TARGET_ARCH in
    aarch64)
      make -f Makefile.libretro platform=aarch64
      ;;
    arm)
      make -f Makefile.libretro USE_DYNAREC=1
      ;;
    x86-64)
      make -f Makefile.libretro
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
