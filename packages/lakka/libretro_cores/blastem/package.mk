PKG_NAME="blastem"
PKG_VERSION="277e4a62668597d4f59cadda1cbafb844f981d45"
PKG_ARCH="x86_64 i386"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/libretro/blastem"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A github mirror for BlastEm - The fast and accurate Genesis emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

[ "${ARCH}" = "i386" ] && PKG_MAKE_OPTS_TARGET+=" ARCH=x86" || true

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
   cp -v blastem_libretro.so ${INSTALL}/usr/lib/libretro/
}
