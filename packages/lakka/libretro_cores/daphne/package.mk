PKG_NAME="daphne"
PKG_VERSION="0a7e6f0fda1348144369ce0a889876df60263e8f"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/libretro/daphne"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Daphne is a laserdisc games emulator"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v daphne_libretro.so ${INSTALL}/usr/lib/libretro/
}

