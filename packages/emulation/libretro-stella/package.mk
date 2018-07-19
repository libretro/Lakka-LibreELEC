# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-stella"
PKG_VERSION="b0d525b"
PKG_SHA256="72f6d611bc51de9da1bd86fb922019d29eb0f30f53386f27e1a404a26736ba1f"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/stella-libretro"
PKG_URL="https://github.com/libretro/stella-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="stella-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.stella: Stella for Kodi"
PKG_LONGDESC="game.libretro.stella: Stella for Kodi"

PKG_LIBNAME="stella_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="STELLA_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
