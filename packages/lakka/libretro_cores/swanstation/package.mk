PKG_NAME="swanstation"
PKG_VERSION="10af0c78ba0e3516e70f4ed7c6020827bdb2647e"
PKG_GIT_CLONE_BRANCH="main"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/swanstation"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="SwanStation(DuckStation) is an simulator/emulator of the Sony PlayStation(TM) console, focusing on playability, speed, and long-term maintainability."
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

PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=Release"

if [ "${PROJECT}" = "Amlogic" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_FBDEV=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_DRMKMS=ON"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v swanstation_libretro.so ${INSTALL}/usr/lib/libretro/
}
