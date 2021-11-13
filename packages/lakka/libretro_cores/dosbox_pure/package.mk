PKG_NAME="dosbox_pure"
PKG_VERSION="3d0266b01cf57571be0487fbaa1d343ef1324307"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dosbox-pure"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="DOSBox Pure is a fork of DOSBox, an emulator for DOS games, built for RetroArch/Libretro aiming for simplicity and ease of use."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v dosbox_pure_libretro.so ${INSTALL}/usr/lib/libretro/
}
