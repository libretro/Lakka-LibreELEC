PKG_NAME="craft"
PKG_VERSION="675c5b2fc690d2e80f6099f46407bf23827c59d4"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/Craft"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A simple Minecraft clone written in C using modern OpenGL (shaders)."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro -C ../"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../craft_libretro.so ${INSTALL}/usr/lib/libretro/
}
