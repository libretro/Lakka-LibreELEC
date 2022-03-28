PKG_NAME="race"
PKG_VERSION="b8264bb"
PKG_LICENSE="GPL2"
PKG_SITE="https://github.com/libretro/RACE"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="NeoGeo Pocket emulator"
PKG_TOOLCHAIN="make"

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET="DRZ80=1"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v race_libretro.so ${INSTALL}/usr/lib/libretro/
}
