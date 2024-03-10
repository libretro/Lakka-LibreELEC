PKG_NAME="flycast"
PKG_VERSION="c1f0a5a15f07ba82ccb974e5c7dc82206324b0a3"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/flyinghead/flycast"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast emulator"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DUSE_OPENMP=OFF \
                       -DCMAKE_BUILD_TYPE=Release"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  if [[ ${DEVICE} =~ ^RPi[4|5].* ]] || [ ${DEVICE} = "RK3288" ] || [ "${DEVICE}" = "RK3399" ]; then
    # enable GLES3
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=ON"
  else
    # enable GLES2
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES2=ON"
  fi
fi

if [ "${VULKAN_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=ON"
fi

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v flycast_libretro.so ${INSTALL}/usr/lib/libretro/
}
