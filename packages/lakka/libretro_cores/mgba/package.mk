PKG_NAME="mgba"
PKG_VERSION="314bf7b676f5b820f396209eb0c7d6fbe8103486"
PKG_LICENSE="MPLv2.0"
PKG_SITE="https://github.com/libretro/mgba"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="mGBA Game Boy Advance Emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../ -f Makefile.libretro"

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=unix-armv"
fi

if target_has_feature neon ; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../mgba_libretro.so ${INSTALL}/usr/lib/libretro/
}
