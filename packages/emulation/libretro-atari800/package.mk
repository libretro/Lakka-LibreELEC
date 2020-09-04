# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-atari800"
PKG_VERSION="ac0bc2e690fda9e0b7c85600bc6b9d2e27e3b41f"
PKG_SHA256="d2197ad9e19b5969844603f35e30a8fbaaba87688a6906fa53b84950ecb17593"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-atari800"
PKG_URL="https://github.com/libretro/libretro-atari800/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Atari 8-bit computer and 5200 console emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="platform=unix"

PKG_LIBNAME="atari800_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="ATARI800_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
