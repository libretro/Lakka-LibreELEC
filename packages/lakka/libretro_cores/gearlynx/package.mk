PKG_NAME="gearlynx"
PKG_VERSION="aed9775f3f53e84f9678f0f7473186ac3078a679"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://github.com/drhelius/Gearlynx"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Atari Lynx emulator, debugger, and embedded MCP server"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C platforms/libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v platforms/libretro/gearlynx_libretro.so ${INSTALL}/usr/lib/libretro/
}
