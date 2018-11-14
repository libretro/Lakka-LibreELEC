# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-pcsx-rearmed"
PKG_VERSION="28ea3e2d87c4e239d8853b10c4496f82feb9d982"
PKG_SHA256="521c4e22bf3b43dfaa0511046adde08daeb1565092f0f93794bd55cf2caac5e0"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="https://github.com/libretro/pcsx_rearmed/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
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
      make -f Makefile.libretro platform=aarch64 GIT_VERSION=$PKG_VERSION
      ;;
    arm)
      make -f Makefile.libretro USE_DYNAREC=1 GIT_VERSION=$PKG_VERSION
      ;;
    x86_64)
      make -f Makefile.libretro GIT_VERSION=$PKG_VERSION
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
