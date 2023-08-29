PKG_NAME="virtualjaguar"
PKG_VERSION="8126e5c504ac7217a638f38e4cd9190822c8abdd"
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
