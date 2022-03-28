PKG_NAME="beetle_supafaust"
PKG_VERSION="a106dbdc8c5ef11f216b21f4ba1b22cb637e599d"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/supafaust"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="SNES emulator for multicore ARM Cortex A7,A9,A15,A53 Linux platforms"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_supafaust_libretro.so ${INSTALL}/usr/lib/libretro/
}
