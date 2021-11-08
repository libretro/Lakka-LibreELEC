PKG_NAME="libretro_database"
PKG_VERSION="65f61a2"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-database"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Repository containing cheatcode files, content data files, etc."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/libretro-database"

  # move cheats to separate folder
  mkdir -p ${INSTALL}/usr/share/libretro-cheats
    mv -v ${INSTALL}/usr/share/libretro-database/cht/* ${INSTALL}/usr/share/libretro-cheats
    rm -r ${INSTALL}/usr/share/libretro-database/cht
}
