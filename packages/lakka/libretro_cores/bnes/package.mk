PKG_NAME="bnes"
PKG_VERSION="8e26e89a93bef8eb8992d1921b539dce1792660a"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/bnes-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro implementation of bNES/higan. (Nintendo Entertainment System)"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bnes_libretro.so ${INSTALL}/usr/lib/libretro/
}
