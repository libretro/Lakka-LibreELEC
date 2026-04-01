PKG_NAME="beetle_vb"
PKG_VERSION="734205c5ead87a89cd1d53fe086f8f8fe660cf1d"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-vb-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro implementation of Mednafen VB (VirtualBoy)"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_vb_libretro.so ${INSTALL}/usr/lib/libretro/
}
