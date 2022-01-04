# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2016"
PKG_VERSION="69711c25c14f990b05fdce87fb92f3b5c312ec1e"
PKG_SHA256="d2ca0d3bb3c600d06725e8e627e59d5e66aaed3f9e55c639f27528ec3d35f743"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2016-libretro"
PKG_URL="https://github.com/libretro/mame2016-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux:host alsa-lib"
PKG_LONGDESC="Late 2016 version of MAME (0.174) for libretro. Compatible with MAME 0.174 romsets."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mame2016_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MAME2016_LIB"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET=" \
    REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python3 CONFIG=libretro \
    LIBRETRO_OS="unix" ARCH="" PROJECT="" LIBRETRO_CPU="${ARCH}" DISTRO="debian-stable" \
    CROSS_BUILD="1" OVERRIDE_CC="${CC}" OVERRIDE_CXX="${CXX}" \
    TARGET="mame" SUBTARGET="arcade" PLATFORM="${ARCH}" RETRO=1 OSD="retro" \
    GIT_VERSION=${PKG_VERSION:0:7}"

  if [ "${ARCH}" = "arm" ]; then
    PKG_MAKE_OPTS_TARGET+=" NOASM="1" ARCHITECTURE="""
  elif [ "${ARCH}" = "x86_64" ]; then
    PKG_MAKE_OPTS_TARGET+=" NOASM="0" PTR64="1""
  fi
}

post_make_target() {
  mv ${PKG_BUILD}/mamearcade2016_libretro.so ${PKG_BUILD}/mame2016_libretro.so
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
