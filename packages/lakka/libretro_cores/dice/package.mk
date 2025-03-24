PKG_NAME="dice"
PKG_VERSION="67685b353e5499e0086d234f47aa352200c0be11"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/mittonk/dice-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="DICE is a Discrete Integrated Circuit Emulator for games without any type of CPU."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v dice_libretro.so ${INSTALL}/usr/lib/libretro/
}
