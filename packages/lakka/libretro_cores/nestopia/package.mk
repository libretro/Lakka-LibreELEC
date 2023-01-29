PKG_NAME="nestopia"
PKG_VERSION="cb1e24e2d6e5d49a85924a9d6dd9c470c109f537"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/nestopia"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro implementation of NEStopia. (Nintendo Entertainment System)"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro/"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/nestopia_libretro.so ${INSTALL}/usr/lib/libretro/
}
