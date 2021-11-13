PKG_NAME="crocods"
PKG_VERSION="86eeccfb68ad6a1cb39ef5b008902f6636d7d194"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-crocods"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Amstrad CPC emulator"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v crocods_libretro.so ${INSTALL}/usr/lib/libretro/
}
