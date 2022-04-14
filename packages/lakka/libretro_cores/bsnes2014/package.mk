PKG_NAME="bsnes2014"
PKG_VERSION="a8f232a38bc54a6b1871d43504a4c098cb5c0709"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/bsnes2014"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro fork of bsnes. As close to upstream as possible."
PKG_TOOLCHAIN="make"

pre_make_target() {
  if [ "${ARCH}" = "aarch64" ];then
    LDFLAGS+=" -lgcc"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bsnes2014_performance_libretro.so ${INSTALL}/usr/lib/libretro/
}
