# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-virtualjaguar"
PKG_VERSION="7bdd8658880b53bf2bcbae0741323fe18f9041f5"
PKG_SHA256="79dd7df650d1ffc20ea1cd91d4abd3372e53240f92c65d3d975c87dbbf79b99f"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/virtualjaguar-libretro"
PKG_URL="https://github.com/libretro/virtualjaguar-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Port of Virtual Jaguar to Libretro"

PKG_LIBNAME="virtualjaguar_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="VIRTUALJAGUAR_LIB"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
