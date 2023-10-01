PKG_NAME="vircon32"
PKG_VERSION="64593bfe9ab2bbf345d1e1d3c9645100aa31c869"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/vircon32/vircon32-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Vircon32 is a virtual game console, inspired by classic 16 & 32 bit systems as well as the arcade era."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=Release"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  if [[ ${DEVICE} =~ ^RPi4.* ]] || [ ${DEVICE} = "RK3288" ] || [ "${DEVICE}" = "RK3399" ]; then
    # enable GLES3
    PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGLES3=ON"
  else
    # enable GLES2
    PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGLES22=ON"
  fi
fi

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v vircon32_libretro.so ${INSTALL}/usr/lib/libretro/
}
