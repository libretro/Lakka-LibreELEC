PKG_NAME="freechaf"
PKG_VERSION="33665bba2c0e9f67f5b53979dd216947adb31a09"
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
