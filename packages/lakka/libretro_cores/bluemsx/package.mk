PKG_NAME="bluemsx"
PKG_VERSION="572c91856a5288b7433c619af651e31f00f3ce7e"
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
