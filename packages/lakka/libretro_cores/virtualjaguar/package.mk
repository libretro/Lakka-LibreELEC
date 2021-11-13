PKG_NAME="virtualjaguar"
PKG_VERSION="fa689ccccb09c27bd7c6fe42dbd8730f8ded5f29"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/virtualjaguar-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Virtual Jaguar to Libretro"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v virtualjaguar_libretro.so ${INSTALL}/usr/lib/libretro/
}
