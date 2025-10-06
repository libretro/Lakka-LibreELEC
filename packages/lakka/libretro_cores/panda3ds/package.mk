PKG_NAME="panda3ds"
PKG_VERSION="2bedba53d33727e3820aed91d39656761f840206"
PKG_LICENSE="GPLv3"
PKG_ARCH="x86_64 aarch64"
PKG_SITE="https://github.com/wheremyfoodat/Panda3DS"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="HLE 3DS emulator"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DBUILD_LIBRETRO_CORE=ON \
                       -DUSE_LIBRETRO_AUDIO=ON \
                       -DENABLE_HTTP_SERVER=OFF \
                       -DENABLE_DISCORD_RPC=OFF \
                       -DENABLE_QT_GUI=OFF \
                       -DENABLE_VULKAN=OFF \
                       -DENABLE_LUAJIT=OFF \
                       -DENABLE_RENDERDOC_API=OFF \
                       -DENABLE_METAL=OFF \
                       -DENABLE_LTO=ON \
                       -DENABLE_USER_BUILD=ON"

if [ "${ARCH}" = "aarch64" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DCRYPTOPP_OPT_DISABLE_ASM=ON"
fi

if [ "${OPENGL_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGL=ON"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGL=ON"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_WAYLAND=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_WAYLAND=OFF"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/panda3ds_libretro.so ${INSTALL}/usr/lib/libretro/
}
