PKG_NAME="beetle_bsnes"
PKG_VERSION="d770563fc3c4bd9abb522952cefb4aa923ba0b91"
PKG_ARCH="x86_64 i386"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-bsnes-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Standalone port of Mednafen bSNES to libretro, itself a fork of bsnes 0.59."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_snes_libretro.so ${INSTALL}/usr/lib/libretro/
}
