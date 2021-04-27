PKG_NAME="bsnes2014"
PKG_VERSION="1c2216f"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/bsnes2014"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Libretro fork of bsnes. As close to upstream as possible."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bsnes2014_performance_libretro.so ${INSTALL}/usr/lib/libretro/
}
