PKG_NAME="swanstation"
PKG_VERSION="789e2d1367d9017cc017947809c6227e64b8a491"
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

PKG_CMAKE_OPTS_TARGET="-DBUILD_NOGUI_FRONTEND=OFF \
                       -DBUILD_QT_FRONTEND=OFF \
                       -DBUILD_LIBRETRO_CORE=ON \
                       -DENABLE_DISCORD_PRESENCE=OFF"

if [ "${PROJECT}" = "Amlogic" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_FBDEV=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_DRMKMS=ON"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v swanstation_libretro.so ${INSTALL}/usr/lib/libretro/
}
