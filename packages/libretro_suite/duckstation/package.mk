PKG_NAME="duckstation"
PKG_VERSION="7c964e1"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/duckstation"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="DuckStation is an simulator/emulator of the Sony PlayStation(TM) console, focusing on playability, speed, and long-term maintainability."
PKG_TOOLCHAIN="cmake"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=Release \
                       -DUSE_DRMKMS=ON \
                       -DBUILD_LIBRETRO_CORE=ON"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v duckstation_libretro.so ${INSTALL}/usr/lib/libretro/
}
