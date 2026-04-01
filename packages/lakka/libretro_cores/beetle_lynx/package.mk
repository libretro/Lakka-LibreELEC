PKG_NAME="beetle_lynx"
PKG_VERSION="40226b7b4fdd2604aa817fb7ded895b665282e25"
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
