PKG_NAME="imame4all"
PKG_VERSION="f35db3877f8a79a174dd3b2e37f4ebf39d71d5a4"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/imame4all-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A port of iMAME4all to libretro"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f makefile.libretro"

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" ARM=1"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro.so ${INSTALL}/usr/lib/libretro/imame4all_libretro.so
}
