# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-nx"
PKG_VERSION="b460024c23ef2cb8a70e1ae00b6b425abaaf49a4"
PKG_SHA256="26b5bb43fc124c0cc8cf3c2c37ef03ba1c3cf8b707e2edbf3b9eeb4d8b9fd37d"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/nxengine-libretro"
PKG_URL="https://github.com/libretro/nxengine-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.nx: nx for Kodi"

PKG_LIBNAME="nxengine_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="NX_LIB"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
