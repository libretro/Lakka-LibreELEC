PKG_NAME="dinothawr"
PKG_VERSION="2e789028a8738ecfbde4da6dc164c41502a94955"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/Dinothawr"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Dinothawr is a block pushing puzzle game on slippery surfaces"
PKG_TOOLCHAIN="make"

if target_has_feature neon; then
  PKG_MAKE_OPTS_TARGET="HAVE_NEON=1"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v dinothawr_libretro.so ${INSTALL}/usr/lib/libretro/
}
