PKG_NAME="xmil"
PKG_VERSION="6a52dc21a5ff106137670bb600ab2ce3fcebeb1b"
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
