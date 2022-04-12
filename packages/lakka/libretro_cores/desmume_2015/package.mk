PKG_NAME="desmume_2015"
PKG_VERSION="af397ff3d1f208c27f3922cc8f2b8e08884ba893"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/desmume2015"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro wrapper for desmume NDS emulator."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C desmume"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=armv"
elif [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=arm64-unix"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v desmume/desmume2015_libretro.so ${INSTALL}/usr/lib/libretro/
}
