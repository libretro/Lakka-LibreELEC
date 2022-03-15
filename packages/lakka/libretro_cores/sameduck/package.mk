PKG_NAME="sameduck"
PKG_VERSION="a5e5462f79164d21053f81fc680bfa9f59a2bf59"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/LIJI32/SameBoy"
PKG_GIT_CLONE_BRANCH="SameDuck"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="An adaptation of SameDuck to play Mega Duck games"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro/"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v build/bin/sameduck_libretro.so ${INSTALL}/usr/lib/libretro/
}
