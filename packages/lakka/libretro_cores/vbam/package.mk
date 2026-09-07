PKG_NAME="vbam"
PKG_VERSION="c5d79e21e08746569269d45e70d44162ecc5ed74"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/visualboyadvance-m/visualboyadvance-m"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="VBA-M with libretro integration"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET=" -DCMAKE_BUILD_TYPE=Release \
                        -DENABLE_SDL=OFF \
                        -DENABLE_WX=OFF \
                        -DENABLE_LINK=OFF \
                        -DENABLE_LIBRETRO=ON \
                        -DENABLE_LUA=OFF \
                        -DENABLE_ONLINEUPDATES=OFF \
                        -DENABLE_WAYLAND_PROTOCOLS=OFF"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_CMAKE_OPTS_TARGET+=" -DDISABLE_OPENGL=OFF"
elif [ "${OPENGL_SUPPORT}" = "no" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DDISABLE_OPENGL=ON"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_GLES=ON"
elif [ "${OPENGLES_SUPPORT}" = "no" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_GLES=OFF"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_VULKAN=ON"
elif [ "${VULKAN_SUPPORT}" = "no" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_VULKAN=OFF"
fi

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/lib/libretro"
    cp -av "${PKG_BUILD}/.${TARGET_NAME}/vbam_libretro.so" "${INSTALL}/usr/lib/libretro/"
}
