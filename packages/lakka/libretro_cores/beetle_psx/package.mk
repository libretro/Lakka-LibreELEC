PKG_NAME="beetle_psx"
PKG_VERSION="8dd1f5ab22a4a28cc2c62cc4aa3dee8f34eced30"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-psx-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Standalone port of Mednafen PSX to libretro."
PKG_TOOLCHAIN="make"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

PKG_MAKE_OPTS_TARGET="HAVE_CDROM=1 LINK_STATIC_LIBCPLUSPLUS=0"

if [ "${OPENGL_SUPPORT}" = "yes" -a "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_HW=1"
elif [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=1"
elif [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_VULKAN=1"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_psx*libretro.so ${INSTALL}/usr/lib/libretro/
}
