PKG_NAME="sameduck"
PKG_VERSION="5cc014b23af963f9e9a77091a1e6ff7a7852e8a7"
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
