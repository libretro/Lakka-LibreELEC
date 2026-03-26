PKG_NAME="azahar"
PKG_VERSION="9b045bf8370d035cacd99e5ad19a082df9e3b262"
PKG_ARCH="x86_64 aarch64"
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://github.com/azahar-emu/azahar"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="An open-source 3DS emulator project based on Citra"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DENABLE_LIBRETRO=ON -DENABLE_TESTS=OFF"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGL=ON"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGL=ON"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_VULKAN=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_VULKAN=OFF"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    if [ "${DEBUG}" = "yes" ]; then
      cp -v bin/Debug/azahar_libretro.so ${INSTALL}/usr/lib/libretro/
    else
      cp -v bin/Release/azahar_libretro.so ${INSTALL}/usr/lib/libretro/
    fi
}
