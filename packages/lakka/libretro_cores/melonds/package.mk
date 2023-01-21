PKG_NAME="melonds"
PKG_VERSION="0e1f06da626cbe67215c3f06f6bdf510dd4e4649"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/melonds"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="DS emulator, sorta"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=1"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  if [ "${OPENGLES}" = "mesa" ]; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=1"
  else
    PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGLES=1"
  fi
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" ARCH=arm64"
  if [ "${PROJECT}" = "L4T" -a "${L4T_DEVICE_TYPE}" = "t210" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=tegra210"
  elif [ "${DEVICE:0:4}" = "RPi4" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=rpi4_64 HAVE_OPENGL=0"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=unix"
  fi
elif [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" platfrom=unix"
  if target_has_feature neon ; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
  fi
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/melonds_libretro.so ${INSTALL}/usr/lib/libretro/
}
