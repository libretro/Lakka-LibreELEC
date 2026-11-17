# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="parallel_dc"
PKG_VERSION="96270615444e9deeb36c9f0b36df2ea39ae37212"
PKG_ARCH="any !i386"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/parallel-dc"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Sega Dreamcast, NAOMI, NAOMI 2 and Atomiswave emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="ARCH=${ARCH}"

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" ARM_FLOAT_ABI_HARD=1"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1"
fi

# Vulkan is decided here, whatever platform the Makefile picks
if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_MAKE_OPTS_TARGET+=" HAVE_VULKAN=1"
else
  PKG_MAKE_OPTS_TARGET+=" HAVE_VULKAN=0"
fi

pre_make_target() {
  if [ "${ARCH}" = "aarch64" ]; then
    # The Makefile drops our CFLAGS, so keep -mno-outline-atomics via CC/CXX
    export CC="${CC} -mno-outline-atomics"
    export CXX="${CXX} -mno-outline-atomics"

    PKG_MAKE_OPTS_TARGET+=" platform=unix"

  elif  [ "${ARCH}" = "arm" ]; then
    # RPi, RPiZero-GPiCase and RPiZero2-GPiCase are excluded in
    # libretro_cores/package.mk, like flycast.
    case ${DEVICE:-$PROJECT} in
      H2-plus|H3)
        PKG_MAKE_OPTS_TARGET+=" platform=sun8i"
        ;;
      R40)
        PKG_MAKE_OPTS_TARGET+=" platform=classic_armv7_a7"
        ;;
      iMX6)
        PKG_MAKE_OPTS_TARGET+=" platform=imx6"
        ;;
      RPi2)
        PKG_MAKE_OPTS_TARGET+=" platform=rpi2-mesa"
        ;;
      RK3288)
        PKG_MAKE_OPTS_TARGET+=" platform=RK3288"
        ;;
      Exynos)
        PKG_MAKE_OPTS_TARGET+=" platform=odroid BOARD=ODROID-XU"
        ;;
    esac
  fi
}

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/lib/libretro"
    cp -v parallel_dc_libretro.so "${INSTALL}/usr/lib/libretro/"
}
