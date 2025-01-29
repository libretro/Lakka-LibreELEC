PKG_NAME="kronos"
PKG_VERSION="58352d6dc969fa90c5fa1220f38ffe577157547f"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/FCare/Kronos"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Kronos to libretro."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../yabause/src/libretro HAVE_CDROM=1"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=1"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ "${ARCH}" = "arm" ]; then
  if [ "${PROJECT}" = "Samsung" -a "${DEVICE}" = "Exynos" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=odroid BOARD=ODROID-XU4"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=armv"
  fi
elif [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=arm64"
fi

pre_make_target() {
  mkdir ${PKG_BUILD}/build_retro
  cd ${PKG_BUILD}/build_retro
  make ${PKG_MAKE_OPTS_TARGET} generate-files
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../yabause/src/libretro/kronos_libretro.so ${INSTALL}/usr/lib/libretro/
}
