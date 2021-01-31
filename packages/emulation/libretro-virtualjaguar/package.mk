# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-virtualjaguar"
PKG_VERSION="d8ab90b1b72aade29b468be60ce8c796d8b6dd1c"
PKG_SHA256="5cc9bbf44ef19663447fbf56e93eec8365d5f1dc3239d1ad3d1663205fabd491"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/virtualjaguar-libretro"
PKG_URL="https://github.com/libretro/virtualjaguar-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Port of Virtual Jaguar to Libretro"

PKG_LIBNAME="virtualjaguar_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="VIRTUALJAGUAR_LIB"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
