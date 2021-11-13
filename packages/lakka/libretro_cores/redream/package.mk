PKG_NAME="redream"
PKG_VERSION="ffb7302245ff40515cb9f0f0b0e233a4b39342d3"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/inolen/redream"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Work In Progress SEGA Dreamcast emulator"
PKG_TOOLCHAIN="make"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="-C ${PKG_BUILD}/deps/libretro CC=${CC} CXX=${CXX}"
  if [ "${ARCH}" = "arm" ]; then
    PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1 WITH_DYNAREC=arm HAVE_NEON=1"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v redream_libretro.so ${INSTALL}/usr/lib/libretro/
}
