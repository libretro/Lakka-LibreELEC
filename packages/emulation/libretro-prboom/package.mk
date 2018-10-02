# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-prboom"
PKG_VERSION="3ff6c1c30ed4f23e2eba4f13a5a4851d401badbe"
PKG_SHA256="2f7b7e19dc7b178facd08874632cf148ce6976f43e9cc1788453fbc9df941037"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-prboom"
PKG_URL="https://github.com/libretro/libretro-prboom/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.prboom: prboom for Kodi"
PKG_LONGDESC="game.libretro.prboom: prboom for Kodi"

PKG_LIBNAME="prboom_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="PRBOOM_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
