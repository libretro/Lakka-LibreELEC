PKG_NAME="theodore"
PKG_VERSION="6304ab73f812a32d5c1ccf554d9ef4425f5a54f7"
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
