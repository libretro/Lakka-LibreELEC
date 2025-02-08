PKG_NAME="theodore"
PKG_VERSION="70cd7965abe607a28ab3cee5689ed433d8f41da3"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/Zlika/theodore"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro core for Thomson MO/TO emulation."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v theodore_libretro.so ${INSTALL}/usr/lib/libretro/
}
