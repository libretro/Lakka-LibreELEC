PKG_NAME="handy"
PKG_VERSION="8133b0a08be2ac7da79a1d79255dbf8787c8be1d"
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
