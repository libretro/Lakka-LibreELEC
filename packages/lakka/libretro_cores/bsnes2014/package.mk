PKG_NAME="bsnes2014"
PKG_VERSION="78dc66f8c09dc0117d55ee4249186674385386e5"
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
