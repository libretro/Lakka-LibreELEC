PKG_NAME="neocd"
PKG_VERSION="2070f5258c9d3feee15962f9db8c8ef20072ece8"
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
