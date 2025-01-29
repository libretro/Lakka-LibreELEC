PKG_NAME="beetle_vb"
PKG_VERSION="8f837ebc077afdd6652efb2827fd8308a07113ca"
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
