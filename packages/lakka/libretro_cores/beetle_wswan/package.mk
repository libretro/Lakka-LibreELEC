PKG_NAME="beetle_wswan"
PKG_VERSION="4e73cf52d5223105a8ac175f4332d609364fb5f9"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-wswan-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro implementation of Mednafen wswan"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_wswan_libretro.so ${INSTALL}/usr/lib/libretro/
}
