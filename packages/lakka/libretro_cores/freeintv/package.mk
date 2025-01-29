PKG_NAME="freeintv"
PKG_VERSION="beab9af119fc117833d2d866d8d4ea0857ec0236"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/FreeIntv"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="FreeIntv is a libretro emulation core for the Mattel Intellivision."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v freeintv_libretro.so ${INSTALL}/usr/lib/libretro/
}
