# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mame2016"
PKG_VERSION="d53c379"
PKG_ARCH="x86_64 aarch64 arm"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2016-libretro"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain linux glibc alsa-lib"
PKG_LONGDESC="Late 2016 version of MAME (0.174) for libretro. Compatible with MAME 0.174 romsets."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="make"

make_target() {
  if [ "${ARCH}" = "arm" ]; then
    PKG_NOASM="1"
  else
    PKG_NOASM="0"
  fi

  if [ "${ARCH}" = "x86_64" ]; then
    PKG_PTR64="1"
  else
    PKG_PTR64="0"
  fi

  make REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python2 CONFIG=libretro \
       LIBRETRO_OS="unix" ARCH="" PROJECT="" LIBRETRO_CPU="${ARCH}" DISTRO="debian-stable" \
       CROSS_BUILD="1" OVERRIDE_CC="${CC}" OVERRIDE_CXX="${CXX}" \
       PTR64="${PKG_PTR64}" NOASM="${PKG_NOASM}" TARGET="mame" \
       SUBTARGET="arcade" PLATFORM="${ARCH}" RETRO=1 OSD="retro" GIT_VERSION=${PKG_VERSION}
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mamearcade2016_libretro.so $INSTALL/usr/lib/libretro/mame2016.so
}
