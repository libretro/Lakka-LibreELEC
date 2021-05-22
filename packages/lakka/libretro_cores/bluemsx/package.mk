PKG_NAME="bluemsx"
PKG_VERSION="527e652"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/blueMSX-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Port of blueMSX to the libretro API."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bluemsx_libretro.so ${INSTALL}/usr/lib/libretro/
}
