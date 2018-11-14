# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-snes9x"
PKG_VERSION="7d9cb8a2a8c86c6c61f8983b3b82d47ea053c9c1"
PKG_SHA256="aee6cc5b288927c3e5cebed0e82cff56d4e2ea7dd13060439549b85a7da1e0eb"
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
