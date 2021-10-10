PKG_NAME="flycast"
PKG_VERSION="beb9a61"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/flycast"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast emulator"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="HAVE_OPENMP=0 LDFLAGS=-lrt"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  if [ "${PROJECT}" = "Generic" ]; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_OIT=1"
  fi
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_MAKE_OPTS_TARGET+=" HAVE_VULKAN=1"
fi

if [ "${ARCH}" = "arm" ]; then
  if [ "${DEVICE:0:4}" = "RPi4" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=rpi4-gles-neon"
  elif [ "${DEVICE}" = "RPi2" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=rpi"
  elif [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=classic_armv8_a35"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=armv-gles-neon"
  fi
elif [ "${DEVICE:0:4}" = "RPi4" -o "${DEVICE}" = "RPi3" ] && [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=rpi4_64-gles-neon"
fi

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" AS=${AS} CC_AS=${CC} ARCH=${ARCH}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v flycast_libretro.so ${INSTALL}/usr/lib/libretro/
}
