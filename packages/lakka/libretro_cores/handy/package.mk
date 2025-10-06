PKG_NAME="handy"
PKG_VERSION="fca239207e9c111da3e85d2faf0b1b9d7524e498"
PKG_LICENSE="Zlib"
PKG_SITE="https://github.com/libretro/libretro-handy"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="K. Wilkins' Atari Lynx emulator Handy for libretro"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v handy_libretro.so ${INSTALL}/usr/lib/libretro/
}
