# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-beetle-pcfx"
PKG_VERSION="a1f1734509dd6acb11269f118d61f480ae8dbacf"
PKG_SHA256="76f22fc238748fb7c63d260f725cae6fa3bd7797ad595ab8116a5c15b7c05e04"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-pcfx-libretro"
PKG_URL="https://github.com/libretro/beetle-pcfx-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Standalone port of Mednafen PCFX to libretro"

PKG_LIBNAME="mednafen_pcfx_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="BEETLE-PCFX_LIB"

make_target() {
  case ${TARGET_CPU} in
    arm1176jzf-s)
      make platform=armv6-hardfloat
      ;;
    cortex-a7|cortex-a8)
      make platform=armv7-neon-hardfloat
      ;;
    cortex-a9|*cortex-a53|cortex-a17)
      if [ "${TARGET_ARCH}" = "aarch64" ]; then
        make platform=aarch64
      else
        make platform=armv7-cortexa9-neon-hardfloat
      fi
      ;;
    x86-64)
      make
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
