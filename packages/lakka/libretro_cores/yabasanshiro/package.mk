PKG_NAME="yabasanshiro"
PKG_VERSION="39535a6abcad5abf9f71c8b2a7975f005ee12ed6"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="yabasanshiro"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of YabaSanshiro to libretro."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C yabause/src/libretro"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ "${ARCH}" = "aarch64" ]; then
  if [ "${PROJECT}" = "Amlogic" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=arm64_cortex_a53_gles3"
  elif [ "${PROJECT}" = "RPi" -a "${DEVICE:0:4}" = "RPi4" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=rpi4"
  elif [ "${PROJECT}" = "RPi" -a "${DEVICE:0:4}" = "RPi5" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=rpi5"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=arm64"
  fi
elif [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=unix-armv"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v yabause/src/libretro/yabasanshiro_libretro.so ${INSTALL}/usr/lib/libretro/
}
