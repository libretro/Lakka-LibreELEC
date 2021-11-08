PKG_NAME="flycast"
PKG_VERSION="6e65f80"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/flycast"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="HAVE_OPENMP=0 LDFLAGS=-lrt"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_MAKE_OPTS_TARGET+=" HAVE_OIT=1"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_MAKE_OPTS_TARGET+=" HAVE_VULKAN=1"
fi

case ${DEVICE:-${PROJECT}} in
  RPi2)
    PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
    ;;
  RPi3)
    PKG_MAKE_OPTS_TARGET+=" platform=rpi3_64"
    ;;
  RPi4*)
    PKG_MAKE_OPTS_TARGET+=" platform=rpi4_64"
    ;;
  RK3288)
    PKG_MAKE_OPTS_TARGET+=" platform=RK3288"
    ;;
  Switch)
    PKG_MAKE_OPTS_TARGET+=" platform=jetson-nano"
    ;;
  *)
    if [ "${ARCH}" = "aarch64" ]; then
      PKG_MAKE_OPTS_TARGET+=" platform=arm64"
    elif [ "${ARCH}" = "arm" ]; then
      PKG_MAKE_OPTS_TARGET+=" platform=armv-gles-neon"
    fi
    ;;
esac

pre_make_target() {
  if [ "${ARCH}" = "arm" -o "${ARCH}" = "aarch64" ]; then
    PKG_MAKE_OPTS_TARGET+=" AS=${AS} CC_AS=${CC}"
  else
    PKG_MAKE_OPTS_TARGET+=" AS=${AS} CC_AS=${AS}"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v flycast_libretro.so ${INSTALL}/usr/lib/libretro/
}
