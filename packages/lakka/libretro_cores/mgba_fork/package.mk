PKG_NAME="mgba_fork"
PKG_VERSION="0f39405ece52cc8b3c20b941ae2a48625865f92d"
PKG_LICENSE="MPLv2.0"
PKG_SITE="https://github.com/libretro/mgba"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="mGBA Game Boy Advance Emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../ -f Makefile.libretro"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../mgba_libretro.so ${INSTALL}/usr/lib/libretro/mgba_fork_libretro.so
}
