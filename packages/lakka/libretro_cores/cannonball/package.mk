PKG_NAME="cannonball"
PKG_VERSION="36f695e18ac2b3832479b3a2f6aabd9dfbb0f34d"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/cannonball"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Cannonball: An Enhanced OutRun Engine"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v cannonball_libretro.so ${INSTALL}/usr/lib/libretro/
}
