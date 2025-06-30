PKG_NAME="libretro_database"
PKG_VERSION="97ca969d058f5401ee06fb8e36a9b6ad7ef82bf2"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-database"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Repository containing cheatcode files, content data files, etc."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/libretro-database"
}
