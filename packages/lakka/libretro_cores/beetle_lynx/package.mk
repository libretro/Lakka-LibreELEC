PKG_NAME="beetle_lynx"
PKG_VERSION="e3da38c7ff73ac0d442482e699c99890ac09f00f"
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
