# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2003_plus"
PKG_VERSION="ab725a7f30a133551742b400089e8fffdf29d84a"
PKG_SHA256="294d0f7bf1c29417714cb24d2aab1f107a4a69fa4e7c574705bc34e214c62d51"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/mame2003-plus-libretro"
PKG_URL="https://github.com/libretro/mame2003-plus-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="MAME - Multiple Arcade Machine Emulator"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mame2003_plus_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MAME2003_PLUS_LIB"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="ARCH= CC=${CC} NATIVE_CC=${CC} LD=${CC}"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake

  mkdir -p ${SYSROOT_PREFIX}/usr/share/libretro-database/mame2003-plus
  cp -v metadata/mame2003-plus.xml ${SYSROOT_PREFIX}/usr/share/libretro-database/mame2003-plus/

  mkdir -p ${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus/samples
  cp -rv metadata/artwork ${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus
  cp -v metadata/{cheat,hiscore,history}.dat ${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus
  # something must be in a folder in order to include it in the image, so why not some instructions
  echo "Put your samples here." > ${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus/samples/readme.txt
}
