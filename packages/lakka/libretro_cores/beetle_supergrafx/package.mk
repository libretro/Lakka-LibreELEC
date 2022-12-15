PKG_NAME="beetle_supergrafx"
PKG_VERSION="5a4563b4b190df00cfe6bb2a464f7d69b0da2317"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-supergrafx-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Standalone port of Mednafen PCE Fast to libretro."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_supergrafx_libretro.so ${INSTALL}/usr/lib/libretro/
}
