PKG_NAME="yabause"
PKG_VERSION="4c96b96f7fbe07223627c469ff33376b2a634748"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Yabause to libretro."
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

if [ "${ARCH}" = "arm" -o "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_SSE=0"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v yabause/src/libretro/yabause_libretro.so ${INSTALL}/usr/lib/libretro/
}
