PKG_NAME="mupen64plus_next"
PKG_VERSION="26fd1edd640ff3db49dd5ebb7e54f0de6600fc45"
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
  PKG_MAKE_OPTS_TARGET+=" GLES=1 FORCE_GLES=1"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

pre_make_target() {
  if [ "${OPENGLES}" = "libmali" ]; then
    CLAGS+=" -DGL_USE_DLSYM"
    CXXFLAGS+=" -DGL_USE_DLSYM"
    LDFLAGS+=" -ldl"
  elif [ "${OPENGLES}" = "bcm2835-driver" ]; then
    CFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/interface/vcos/pthreads \
              -I${SYSROOT_PREFIX}/usr/include/interface/vmcs_host/linux"
    CXXFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/interface/vcos/pthreads \
                -I${SYSROOT_PREFIX}/usr/include/interface/vmcs_host/linux"
  fi

  case ${DEVICE:-$PROJECT} in
    RPi)
      PKG_MAKE_OPTS_TARGET+=" platform=rpi-mesa"
      ;;
    RPi2)
      PKG_MAKE_OPTS_TARGET+=" platform=rpi2-mesa"
      ;;
    RPi3)
      PKG_MAKE_OPTS_TARGET+=" platform=rpi3_64-mesa"
      ;;
    Pi02GPi)
      PKG_MAKE_OPTS_TARGET+=" platform=rpi3"
      ;;
    RPiZero2-GPiCASE2W)
      PKG_MAKE_OPTS_TARGET+=" platform=rpi3_64-mesa"
      ;;
    RPi4*)
      PKG_MAKE_OPTS_TARGET+=" platform=rpi4_64-mesa FORCE_GLES3=1"
      ;;
    Exynos)
      PKG_MAKE_OPTS_TARGET+=" platform=odroid BOARD=ODROID-XU"
      ;;
    H6)
      PKG_MAKE_OPTS_TARGET+=" platform=rpi3_64-mesa"
      ;;
    AMLGX)
      [ "${ARCH}" = "arm" ] && PKG_MAKE_OPTS_TARGET+=" platform=AMLGX-amlogic" || true
      ;;
    OdroidGoAdvance)
      PKG_MAKE_OPTS_TARGET+=" platform=odroid BOARD=ODROIDGOA"
      ;;
    RK3328)
      [ "${ARCH}" = "arm"] && PKG_MAKE_OPTS_TARGET+=" platform=RK3328" || true
      ;;
    RK3399)
      [ "${ARCH}" = "arm"] && PKG_MAKE_OPTS_TARGET+=" platform=RK3399" || true
      ;;
    RK3288)
      PKG_MAKE_OPTS_TARGET+=" platform=RK3288"
      ;;
    Generic)
      PKG_MAKE_OPTS_TARGET+=" HAVE_PARALLEL_RDP=1 HAVE_PARALLEL_RSP=1 HAVE_THR_AL=1 LLE=1"
      ;;
    *)
      PKG_MAKE_OPTS_TARGET+=" platform=unix"
      ;;
  esac

  if target_has_feature neon ; then
    [ "${ARCH}" = "arm" ] && PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1" || true
  fi

  case ${ARCH} in
    i386)
      PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=x86"
      ;;
    *)
      PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=${ARCH}"
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mupen64plus_next_libretro.so ${INSTALL}/usr/lib/libretro/
}
