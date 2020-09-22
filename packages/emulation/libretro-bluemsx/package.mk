# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-bluemsx"
PKG_VERSION="a7b20ae1cd89b3cc487a7fa74704364c72f641cc"
PKG_SHA256="c2be3f0ed4c75b3161e341c739a89819817a923f03b8b476f4450079a86ffe65"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/blueMSX-libretro"
PKG_URL="https://github.com/libretro/blueMSX-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.bluemsx: BlueMSX for Kodi"

PKG_LIBNAME="bluemsx_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="BLUEMSX_LIB"

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
