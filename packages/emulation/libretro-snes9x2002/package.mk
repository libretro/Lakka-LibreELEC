# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-snes9x2002"
PKG_VERSION="0d957c061e3365a33672cbd6ad404bb64f9442f6"
PKG_SHA256="405bea7d682c069e6b052570376eb111b8eff6b24a3fcaa93ca06207135e5e0d"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/snes9x2002"
PKG_URL="https://github.com/libretro/snes9x2002/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Port of SNES9x 1.39 for libretro. Heavily optimized for ARM."

PKG_LIBNAME="snes9x2002_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="SNES9X2002_LIB"

pre_make_target() {
  export CFLAGS="${CFLAGS} -std=gnu11"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
