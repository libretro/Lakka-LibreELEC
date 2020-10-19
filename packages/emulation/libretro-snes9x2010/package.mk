# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-snes9x2010"
PKG_VERSION="5b70b056e27b360684869470a7143294865b7f05"
PKG_SHA256="39b9af85d459730a0f292913ab26567dd95485ae33a8ec0294d224e6b4096b60"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/snes9x2010"
PKG_URL="https://github.com/libretro/snes9x2010/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="snes9x2010 for Kodi"

PKG_LIBNAME="snes9x2010_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="SNES9X2010_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
