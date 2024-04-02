PKG_NAME="ppsspp"
PKG_VERSION="d479b74ed9c3e321bc3735da29bc125a2ac3b9b2"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain glibc libzip libpng zstd zlib bzip2 openssl speex"
PKG_LONGDESC="Libretro port of PPSSPP"
PKG_TOOLCHAIN="cmake"
PKG_LR_UPDATE_TAG="yes"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DUSE_FFMPEG=ON \
                       -DUSE_SYSTEM_FFMPEG=OFF \
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
else
  PKG_CMAKE_OPTS_TARGET+=" -DVULKAN=OFF"
fi

if [ "${OPENGL_SUPPORT}" = "no" -a "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DUSING_GLES2=ON"
fi

if [ "${TARGET_ARCH}" = "arm" ]; then
  if [[ "${TARGET_NAME}" =~ "armv8" ]]; then
    PKG_CMAKE_OPTS_TARGET+=" -DFORCED_CPU=armv8"
  else
    PKG_CMAKE_OPTS_TARGET+=" -DFORCED_CPU=armv7"
  fi
elif [ "${TARGET_ARCH}" = "aarch64" ]; then
  "${TARGET_ARCH}" = "arm64"
  PKG_CMAKE_OPTS_TARGET+=" -DFORCED_CPU=aarch64"
fi

pre_make_target() {
#This script should work on any board that has issues with system ffmpeg in ppsspp
if [ "${ARCH}" = "aarch64" ]; then
  . ${PKG_BUILD}/ffmpeg/linux_lakka.sh
fi
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v lib/ppsspp_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch/system/PPSSPP
    cp -rv assets/* ${INSTALL}/usr/share/retroarch/system/PPSSPP/
}
