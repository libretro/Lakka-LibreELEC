PKG_NAME="nxengine"
PKG_VERSION="fc102fa3eeda1a0133f80474d6671af4cf7612a6"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/nxengine-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL"
PKG_LONGDESC="Port of NxEngine to libretro - Cave Story game engine clone"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v nxengine_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch-assets/nxengine
    cp -vr datafiles/* ${INSTALL}/usr/share/retroarch-assets/nxengine
}
