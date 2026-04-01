PKG_NAME="numero"
PKG_VERSION="28d25413b47e289ed7211fa39c886e223eaed407"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/nbarkhina/numero"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TI-83 Emulator for Libretro"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v numero_libretro.so ${INSTALL}/usr/lib/libretro/
}
