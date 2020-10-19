# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-snes9x"
PKG_VERSION="975aecb88830e6719e267e38144da47eb707fbac"
PKG_SHA256="caa4fa80eac5a873452b980865103dd96a90779392e84d0cdcdfadd35fc89cb6"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/snes9x"
PKG_URL="https://github.com/libretro/snes9x/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.snes9x: snes9x for Kodi"
PKG_TOOLCHAIN="manual"

PKG_LIBNAME="snes9x_libretro.so"
PKG_LIBPATH="libretro/$PKG_LIBNAME"
PKG_LIBVAR="SNES9X_LIB"

make_target() {
  make -C libretro/
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
