PKG_NAME="numero"
PKG_VERSION="0f8b94437f0a884d2f923cb7f17b61f2f0bf0040"
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
