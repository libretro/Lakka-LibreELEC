PKG_NAME="freechaf"
PKG_VERSION="bc5a4ee2889930b7b8d1dd390c8c6ba29f7644dd"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/libretro/FreeChaF"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Fairchild ChannelF Libretro core"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v freechaf_libretro.so ${INSTALL}/usr/lib/libretro/
}
