PKG_NAME="imame4all"
PKG_VERSION="905808fbcc3adf8c610c1c60f0e41ce4b35db1c5"
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
