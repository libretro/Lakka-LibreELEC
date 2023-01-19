PKG_NAME="freechaf"
PKG_VERSION="4d1d5cb83b93728a63f03454e472a23055d9bbfc"
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
