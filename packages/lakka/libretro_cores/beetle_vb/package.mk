PKG_NAME="beetle_vb"
PKG_VERSION="a91437af0879124aa00b6cb30ca1189f2c84b7cb"
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
