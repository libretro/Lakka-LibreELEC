PKG_NAME="ppsspp"
PKG_VERSION="f7ace3b"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="v1.11-hotfixes"
PKG_DEPENDS_TARGET="toolchain ffmpeg libzip libpng"
PKG_SHORTDESC="Libretro port of PPSSPP"
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

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=yes \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DUSE_FFMPEG=yes \
                       -DUSE_SYSTEM_FFMPEG=yes \
                       -DUSE_DISCORD=no \
                       -DUSE_MINIUPNPC=no \
                       --target ppsspp_libretro"

if [ "${OPENGL_SUPPORT}" = "no" -a "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DUSING_GLES2=yes"
fi

if [ "${TARGET_ARCH}" = "arm" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DARMV7=yes"
elif [ "${TARGET_ARCH}" = "aarch64" ]; then
  PKG_CMAKE_OPTS_TARGET=" -DARM64=yes"
fi

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v lib/ppsspp_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch-system/PPSSPP
    cp -rv assets/* ${INSTALL}/usr/share/retroarch-system/PPSSPP/
}
