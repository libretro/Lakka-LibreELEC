# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-snes9x2010"
PKG_VERSION="ead24f29b2af0df83f3365d3e887bdd81979c1a2"
PKG_SHA256="eb23f0fd0179db95fa26f650030cc7e35c0ab01108e12f4ba8229bc5e629a750"
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
