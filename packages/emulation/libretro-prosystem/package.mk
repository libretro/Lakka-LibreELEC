# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-prosystem"
PKG_VERSION="360c65d"
PKG_SHA256="99bb9119ac2105550457b35720fe118e90fb9805c5b15a20471ea87f11b2172e"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/prosystem-libretro"
PKG_URL="https://github.com/libretro/prosystem-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="prosystem-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="Port of ProSystem to libretro"
PKG_LONGDESC="Port of ProSystem to libretro"

PKG_LIBNAME="prosystem_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="PROSYSTEM_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
