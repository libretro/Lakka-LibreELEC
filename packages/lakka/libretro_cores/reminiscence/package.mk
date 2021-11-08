PKG_NAME="reminiscence"
PKG_VERSION="dbf2f59"
PKG_SITE="https://github.com/libretro/REminiscence"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_LONGDESC="Port of Gregory Montoir's Flashback emulator, running as a libretro core."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v reminiscence_libretro.so ${INSTALL}/usr/lib/libretro/
}
