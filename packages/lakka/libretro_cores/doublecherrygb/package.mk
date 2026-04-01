PKG_NAME="doublecherrygb"
PKG_VERSION="2e7a8bd5442ad7b2cb98ea07dbb5000ac95193e9"
PKG_LICENSE="AGPLv3"
PKG_SITE="https://github.com/TimOelrichs/doublecherryGB-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro gameboy core with up to 16 players support and buildtin Pokemon Distribution Events - hardfork from tgbdual-libretro"
PKG_TOOLCHAIN="cmake"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v DoubleCherryGB_libretro.so ${INSTALL}/usr/lib/libretro/
}
