PKG_NAME="tyrquake"
PKG_VERSION="9dcc3ff4ccf96d2f7aa029b738f2c90685b9257f"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/tyrquake"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro port of Tyrquake (Quake 1 engine)"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v tyrquake_libretro.so ${INSTALL}/usr/lib/libretro/
}
