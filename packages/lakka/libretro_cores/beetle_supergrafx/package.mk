PKG_NAME="beetle_supergrafx"
PKG_VERSION="b9cb84001a8b89aa8f4f4602f83d7bf1f1a356b4"
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
