PKG_NAME="fceumm"
PKG_VERSION="7fad08e5522e5396a1196055fc106be9b5d5de77"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-fceumm"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of FCEUmm / FCEUX to Libretro."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v fceumm_libretro.so ${INSTALL}/usr/lib/libretro/
}
