PKG_NAME="beetle_lynx"
PKG_VERSION="b84c79b2f185482f9cec2b10f33cbe1bc5732dd9"
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
