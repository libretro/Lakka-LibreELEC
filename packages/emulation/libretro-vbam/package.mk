# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vbam"
PKG_VERSION="254f6effebe882b7d3d29d9e417c6aeeabc08026"
PKG_SHA256="0c96037a925d715c47a1d96c36107f25fbd31c990dd28754d71a64873f518c6d"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vbam-libretro"
PKG_URL="https://github.com/libretro/vbam-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.vbam: VBA-M for Kodi"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="vbam_libretro.so"
PKG_LIBPATH="src/libretro/${PKG_LIBNAME}"
PKG_LIBVAR="VBAM_LIB"

pre_configure_target() {
  # fails to build in subdirs
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}
}

make_target() {
  make -C src/libretro
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
