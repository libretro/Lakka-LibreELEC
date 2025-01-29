PKG_NAME="gpsp"
PKG_VERSION="b0d5d27ae51c23f514974ddffa5760f1e1d05d9b"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/gpsp"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="gpSP for libretro"
PKG_TOOLCHAIN="make"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="CC=${CC}"
  if [ "${ARCH}" = "arm" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=armv"
  elif [ "${ARCH}" = "aarch64" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=arm64"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v gpsp_libretro.so ${INSTALL}/usr/lib/libretro/
}
