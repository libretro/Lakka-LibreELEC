PKG_NAME="libretro_database"
PKG_VERSION="395ef4922a2017fb324221f93753682163ba1e6a"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-database"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Repository containing cheatcode files, content data files, etc."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/libretro-database"
}
