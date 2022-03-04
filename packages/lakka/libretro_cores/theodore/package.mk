PKG_NAME="theodore"
PKG_VERSION="563fb989f12c7176824b34bbc726bf24d933e86c"
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
