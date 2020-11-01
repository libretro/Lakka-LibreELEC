# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-bsnes-mercury-balanced"
PKG_VERSION="60d38df01b2cb389fe61c8d821315691374a8b27"
PKG_SHA256="01f1678445a358d762ef021148c62c646b7591da73942742af9e58c5f85e227e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/bsnes-mercury"
PKG_URL="https://github.com/libretro/bsnes-mercury/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.beetle-bsnes-balanced: Beetle bSNES for Kodi"

PKG_LIBNAME="bsnes_mercury_balanced_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="BSNES-MERCURY-BALANCED_LIB"

make_target() {
  make PROFILE=balanced
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
