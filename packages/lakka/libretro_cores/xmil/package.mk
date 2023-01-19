PKG_NAME="xmil"
PKG_VERSION="4cb1e4eaab37321904144d1f1a23b2830268e8df"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/libretro/xmil-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro port of X Millennium Sharp X1 emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro/ -f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/x1_libretro.so ${INSTALL}/usr/lib/libretro/
}
