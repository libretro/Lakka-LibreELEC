PKG_NAME="fake_08"
PKG_VERSION="0d26fd59103941e5f95e0ee665c6e0fb8c6b6f03"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/jtothebell/fake-08"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A Pico-8 player/emulator for console homebrew"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C platform/libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v platform/libretro/fake08_libretro.so ${INSTALL}/usr/lib/libretro/
}
