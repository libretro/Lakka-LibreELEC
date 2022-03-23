PKG_NAME="prboom"
PKG_VERSION="4191903047650b40476f7f7584f4e2248789e4b7"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-prboom"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro implementation of Doom"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v prboom_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch-system/
    cp -v prboom.wad ${INSTALL}/usr/share/retroarch-system/
}
