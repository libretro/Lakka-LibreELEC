# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2015"
PKG_VERSION="d43c94fde66ce419800882a344002a2736d163df"
PKG_SHA256="dcda8f6d416132b810be84187cc525ce3223d18c7609f1f2b29dba45a4cd8564"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2015-libretro"
PKG_URL="https://github.com/libretro/mame2015-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Late 2014/Early 2015 version of MAME (0.160-ish) for libretro. Compatible with MAME 0.160 romsets."

PKG_LIBNAME="mame2015_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MAME2015_LIB"

pre_make_target() {
  export REALCC=${CC}
  export CC=${CXX}
  export LD=${CXX}
}

make_target() {
  case ${TARGET_CPU} in
    arm1176jzf-s)
      make platform=armv6-hardfloat-${TARGET_CPU}
      ;;
    cortex-a7|cortex-a9)
      make platform=armv7-neon-hardfloat-${TARGET_CPU}
      ;;
    *cortex-a53|cortex-a17)
      if [ "${TARGET_ARCH}" = "aarch64" ]; then
        make platform=aarch64
      else
        make platform=armv7-neon-hardfloat-cortex-a9
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
