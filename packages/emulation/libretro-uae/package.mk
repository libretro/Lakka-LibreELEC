# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-uae"
PKG_VERSION="5d70a409b424754bc84aea3625354fee8af1fb23"
PKG_SHA256="621cd1d3736e342c84a37bd26332d0d7ce19adef2ebaafed490753d13725bfee"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-uae"
PKG_URL="https://github.com/libretro/libretro-uae/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="libretro wrapper for UAE emulator."
PKG_BUILD_FLAGS="-lto"

PKG_LIBNAME="puae_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="UAE_LIB"

pre_configure_target() {
  CFLAGS+=" -fcommon"
  if [ "${TARGET_ARCH}" = "arm" ]; then
    CFLAGS+=" -DARM -marm"
  fi
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
