# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vbam"
PKG_VERSION="2a796d48a027adc64cc80792cd5e684f19b847e9"
PKG_SHA256="8527f5f46e8e86a88bbecb809d28b2fd3d9e6c28e13d20088e86b25fd880148d"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vbam-libretro"
PKG_URL="https://github.com/libretro/vbam-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.vbam: VBA-M for Kodi"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="vbam_libretro.so"
PKG_LIBPATH="src/libretro/$PKG_LIBNAME"
PKG_LIBVAR="VBAM_LIB"

pre_configure_target() {
  # fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
}

make_target() {
  make -C src/libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
