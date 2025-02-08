PKG_NAME="retro8"
PKG_VERSION="a235ff8e3ca1b44bcf88293748d5a492c76a2c7b"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/libretro/retro8"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="PICO-8 implementation"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../retro8_libretro.so ${INSTALL}/usr/lib/libretro/
}
