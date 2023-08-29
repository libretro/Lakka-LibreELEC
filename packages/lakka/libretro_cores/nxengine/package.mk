PKG_NAME="nxengine"
PKG_VERSION="1f371e51c7a19049e00f4364cbe9c68ca08b303a"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/nxengine-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL"
PKG_LONGDESC="Port of NxEngine to libretro - Cave Story game engine clone"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v nxengine_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch/system/nxengine
    cp -vr datafiles/* ${INSTALL}/usr/share/retroarch/system/nxengine
}
