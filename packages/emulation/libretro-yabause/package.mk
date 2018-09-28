# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-yabause"
PKG_VERSION="fae968218a93d10ca9b811ed47df942f8bec697d"
PKG_SHA256="b48318d2192d06edc6d4e22c3fa508a625716b31216a34aec74c7d5edc205511"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="https://github.com/libretro/yabause/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="yabause-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.yabause: Yabause for Kodi"
PKG_LONGDESC="game.libretro.yabause: Yabause for Kodi"
PKG_TOOLCHAIN="manual"

PKG_LIBNAME="yabause_libretro.so"
PKG_LIBPATH="libretro/$PKG_LIBNAME"
PKG_LIBVAR="YABAUSE_LIB"

make_target() {
  make -C libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
