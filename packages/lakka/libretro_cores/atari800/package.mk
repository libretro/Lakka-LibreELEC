PKG_NAME="atari800"
PKG_VERSION="478a8ec99a7f8436a39d5ac193c5fe313233ee7b"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-atari800"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro port of Atari800 emulator version 3.1.0"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v atari800_libretro.so ${INSTALL}/usr/lib/libretro/
}
