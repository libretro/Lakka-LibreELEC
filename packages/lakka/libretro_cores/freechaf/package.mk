PKG_NAME="freechaf"
PKG_VERSION="ae46e7586c8be6ab0bdf5529e8138639b920adce"
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
