# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-scummvm"
PKG_VERSION="2a272d90dcf2783c7866b866e43912c05a4bfc4b"
PKG_SHA256="c55f862b1527f74f55108574af8fd3af8ca9d0b672eb07bbbab0ec5bc07a406c"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/scummvm-wrapper"
PKG_URL="https://github.com/libretro/scummvm-wrapper/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ScummVM with libretro backend."
PKG_TOOLCHAIN="make"
PKG_LR_UPDATE_TAG="yes"

PKG_LIBNAME="scummvm_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="SCUMMVM_LIB"

PKG_MAKE_OPTS_TARGET="all"

pre_make_target() {
  CXXFLAGS+=" -DHAVE_POSIX_MEMALIGN=1"
  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=oga_a35_neon_hardfloat"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=${TARGET_NAME}"
  fi
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  cp scummvm_libretro.info ${SYSROOT_PREFIX}/usr/lib/
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake

  # unpack files to retroarch-system folder and create basic ini file
  mkdir -p ${SYSROOT_PREFIX}/usr/share/retroarch/system
  unzip scummvm.zip -d ${SYSROOT_PREFIX}/usr/share/retroarch/system

  cat << EOF > ${SYSROOT_PREFIX}/usr/share/retroarch/system/scummvm.ini
[scummvm]
extrapath=/tmp/system/scummvm/extra
browser_lastpath=/tmp/system/scummvm/extra
themepath=/tmp/system/scummvm/theme
guitheme=scummmodern
EOF
}
