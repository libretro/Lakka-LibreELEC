PKG_NAME="swanstation"
PKG_VERSION="50a6a5e"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/swanstation"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="SwanStation is Libretro port of DuckStation - an simulator/emulator of the Sony PlayStation(TM) console, focusing on playability, speed, and long-term maintainability."
PKG_TOOLCHAIN="cmake"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
else
  # Compile with software renderer as default for devices not suporting OpenGL
  # Note: some OpenGL ES device are able to use the OpenGL renderer of SwanStation
  # so the condition for patch dir in/ex-clusion can be changed to PROJECT / DEVICE
  # in the future. However falling back to SW does at least not make the core unusable
  # on platforms without OpenGL support
  PKG_PATCH_DIRS="no_opengl"
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
    cp -v swanstation_libretro.so ${INSTALL}/usr/lib/libretro/
}
