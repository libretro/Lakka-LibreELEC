PKG_NAME="parallel_n64"
PKG_VERSION="0a67445"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/parallel-n64"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Optimized/rewritten Nintendo 64 emulator made specifically for Libretro. Originally based on Mupen64 Plus."
PKG_TOOLCHAIN="make"

if [ "${ARCH}" = "i386" ]; then
  PKG_MAKE_OPTS_TARGET="WITH_DYNAREC=x86"
else
  PKG_MAKE_OPTS_TARGET="WITH_DYNAREC=${ARCH}"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

pre_make_target() {
  if [ "${ARCH}" = "arm" -o "${ARCH}" = "aarch64" ]; then
    CFLAGS+=" -DARM_FIX"
  fi

  if [ "${PROJECT}" = "RPi" ]; then
    if [ "${DEVICE}" = "RPi" -o "${DEVICE}" = "Gamegirl" -o "${DEVICE}" = "GPICase" ]; then
      PKG_MAKE_OPTS_TARGET+=" platform=rpi"
    elif [ "${DEVICE}" = "RPi4" ]; then
      LDFLAGS+=" -lpthread"
      if [ "${ARCH}" = "aarch64" ]; then
        PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1 HAVE_PARALLEL=1"
      else
        PKG_MAKE_OPTS_TARGET+=" platform=armv-neon HAVE_PARALLEL=1"
      fi
    fi
  elif target_has_feature neon ; then
    CFLAGS+=" -DGL_BGRA_EXT=0x80E1" # Fix build for platforms where GL_BGRA_EXT is not defined
    PKG_MAKE_OPTS_TARGET+=" platform=armv-gles-neon"
  elif [ "${PROJECT}" =  "Rockchip" -a "${ARCH}" = "aarch64" ]; then
    LDFLAGS+=" -lpthread"
    PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1 HAVE_PARALLEL=1"
  else
    LDFLAGS+=" -lpthread"
    PKG_MAKE_OPTS_TARGET+=" HAVE_PARALLEL=0"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v parallel_n64_libretro.so ${INSTALL}/usr/lib/libretro/
}
