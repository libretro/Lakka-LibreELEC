PKG_NAME="tyrquake"
PKG_VERSION="19aa11e965a6dbb31d418e99bcd14d86eb822b20"
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
