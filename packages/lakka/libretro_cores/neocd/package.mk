PKG_NAME="neocd"
PKG_VERSION="9216ca226f24e01e77fc2670035e97da154f3de4"
PKG_LICENSE="LGPLv3"
PKG_SITE="https://github.com/libretro/neocd_libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Neo Geo CD emulator for libretro"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v neocd_libretro.so ${INSTALL}/usr/lib/libretro/
}
