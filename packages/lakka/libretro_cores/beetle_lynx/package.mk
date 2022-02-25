PKG_NAME="beetle_lynx"
PKG_VERSION="26d94696eb005499d981970f052fdd7beda12c1e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-lynx-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro implementation of Mednafen Lynx"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_lynx_libretro.so ${INSTALL}/usr/lib/libretro/
}
