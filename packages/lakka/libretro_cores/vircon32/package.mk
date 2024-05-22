PKG_NAME="vircon32"
PKG_VERSION="293d0b2b0e3b996b991b7a667ec31a64d8865450"
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

  get_graphicdrivers

  if listcontains "${GRAPHIC_DRIVERS}" "panfrost" && ! listcontains "${MALI_FAMILY}" "(t720|t620)"; then
    PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGLES3=ON"
  elif listcontains "${GRAPHIC_DRIVERS}" "lima" || listcontains "${MALI_FAMILY}" "(400|450|t720)"; then
    PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGLES2=ON"
  elif listcontains "${GRAPHIC_DRIVERS}" "vc4" && [ "${DEVICE:0:4}" = "RPi4" -o "${DEVICE}" = "RPi5" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGLES3=ON"
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGLES3=ON"
  else
    PKG_CMAKE_OPTS_TARGET+=" -DENABLE_OPENGLES2=ON"
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
