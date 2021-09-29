PKG_NAME="mupen64plus_next"
PKG_VERSION="34aec88"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro-nx"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="develop"
PKG_DEPENDS_TARGET="toolchain nasm:host"
PKG_LONGDESC="mupen64plus_next + RSP-HLE + GLideN64 + libretro"

PKG_MAKE_OPTS_TARGET="ARCH=${ARCH}"

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
  if [ "${OPENGLES}" = "libmali" ]; then
    CLAGS+=" -DGL_USE_DLSYM"
    CXXFLAGS+=" -DGL_USE_DLSYM"
    LDFLAGS+=" -ldl"
  elif [ "${OPENGLES}" = "bcm-2835-driver" ]; then
    CFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/interface/vcos/pthreads \
              -I${SYSROOT_PREFIX}/usr/include/interface/vmcs_host/linux"
    CXXFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/interface/vcos/pthreads \
                -I${SYSROOT_PREFIX}/usr/include/interface/vmcs_host/linux"
  fi

  case ${DEVICE:-$PROJECT} in
    RPi|Gamegirl)
      PKG_MAKE_OPTS_TARGET+=" platform=rpi-mesa"
      ;;
    RPi2)
      PKG_MAKE_OPTS_TARGET+=" platform=rpi2-mesa"
      ;;
    RPi4)
      PKG_MAKE_OPTS_TARGET+=" platform=rpi4"
      ;;
    OdroidXU3)
      PKG_MAKE_OPTS_TARGET+=" platform=odroid BOARD=ODROID-XU"
      ;;
    AMLG*)
      PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}-amlogic"
      ;;
    OdroidGoAdvance)
      PKG_MAKE_OPTS_TARGET+=" platform=odroid BOARD=ODROIDGOA"
      ;;
    RK3328)
      PKG_MAKE_OPTS_TARGET+=" platform=RK3328 GLES=1 FORCE_GLES=1"
      ;;
    RK3399)
      PKG_MAKE_OPTS_TARGET+=" platform=RK3399 GLES=1 FORCE_GLES=1"
      ;;
    RK3328)
      PKG_MAKE_OPTS_TARGET+=" platform=RK3288 GLES=1 FORCE_GLES=1"
      ;;
    *)
      PKG_MAKE_OPTS_TARGET+=" platform=unix"
      if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
        PKG_MAKE_OPTS_TARGET+=" GLES=1 FORCE_GLES=1"
      fi
      if target_has_feature neon ; then
        PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
      fi
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mupen64plus_next_libretro.so ${INSTALL}/usr/lib/libretro/
}
