PKG_NAME="prboom"
PKG_VERSION="b3e5f8b2e8855f9c6fc7ff7a0036e4e61379177d"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-prboom"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro implementation of Doom"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v prboom_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch/system/
    cp -v prboom.wad ${INSTALL}/usr/share/retroarch/system/
}
