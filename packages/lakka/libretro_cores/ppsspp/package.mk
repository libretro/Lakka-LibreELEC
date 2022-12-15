PKG_NAME="ppsspp"
PKG_VERSION="9fe6338e3bf397f8a009a51a282c139dfa180eb6" #v1.13.2
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="https://github.com/hrydgard/ppsspp.git"
PKG_DEPENDS_TARGET="toolchain linux glibc libzip libpng zstd zlib ffmpeg bzip2 openssl speex"
PKG_LONGDESC="A PSP emulator for Android, Windows, Mac, Linux and Blackberry 10, written in C++."
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_BRANCH="master"
PKG_GIT_CLONE_SINGLE="yes"
PKG_BUILD_FLAGS="-sysroot"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DUSE_FFMPEG=ON \
                       -DUSE_SYSTEM_FFMPEG=ON \
                       -DUSE_SYSTEM_LIBZIP=ON \
                       -DUSE_SYSTEM_LIBPNG=ON \
                       -DUSE_SYSTEM_ZSTD=ON \
                       -DUSE_DISCORD=OFF \
                       -DUSE_MINIUPNPC=OFF"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS_TARGET+=" -DVULKAN=ON"
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DUSING_X11_VULKAN=ON"
  else
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN_DISPLAY_KHR=ON -DUSING_X11_VULKAN=OFF"
  fi
fi

if [ "${OPENGL_SUPPORT}" = "no" -a "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DUSING_GLES2=ON"
fi

if [ "${TARGET_ARCH}" = "arm" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DARMV7=ON"
elif [ "${TARGET_ARCH}" = "aarch64" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DARM64=ON"
fi

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v lib/ppsspp_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch/system/PPSSPP
    cp -rv assets/* ${INSTALL}/usr/share/retroarch/system/PPSSPP/
}
