PKG_NAME="bluemsx"
PKG_VERSION="8af516705652d240ef5bc69dea8276d0fdd16323"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/blueMSX-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of blueMSX to the libretro API."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bluemsx_libretro.so ${INSTALL}/usr/lib/libretro/
}
