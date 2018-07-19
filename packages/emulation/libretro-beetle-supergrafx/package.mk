# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-beetle-supergrafx"
PKG_VERSION="0d4d964"
PKG_SHA256="25ca680d554fd0e1f1bc84e7910102aac46af01ae9e1eda855e5b68ea3bbb49a"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-supergrafx-libretro"
PKG_URL="https://github.com/libretro/beetle-supergrafx-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="beetle-supergrafx-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="Standalone port of Mednafen PCE Fast to libretro. This one only emulates a SuperGrafx TG-16"
PKG_LONGDESC="Standalone port of Mednafen PCE Fast to libretro. This one only emulates a SuperGrafx TG-16"

PKG_LIBNAME="mednafen_supergrafx_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="BEETLE-SUPERGRAFX_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
