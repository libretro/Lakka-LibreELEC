# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-meteor"
PKG_VERSION="bc6bbc06f00afd69803fe30a923be9bb95c73cb6"
PKG_SHA256="f718aa75a079539a01fad6d349afe38f06b762272d498640e29467d2f3c8b4cd"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/meteor-libretro"
PKG_URL="https://github.com/libretro/meteor-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.meteor: Meteor GBA for Kodi"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="meteor_libretro.so"
PKG_LIBPATH="libretro/$PKG_LIBNAME"
PKG_LIBVAR="METEOR_LIB"

pre_configure_target() {
  # fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
}

make_target() {
  make -C libretro/
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
