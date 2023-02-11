PKG_NAME="beetle_pcfx"
PKG_VERSION="632c87702f92950c476c647939914b9ec162cbfa"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-pcfx-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro implementation of Mednafen PC-FX."
PKG_TOOLCHAIN="make"

if [ "${ARCH}" = "i386" -o "${ARCH}" = "x86_64" ]; then
  PKG_MAKE_OPTS_TARGET="platform=unix"
else
  PKG_MAKE_OPTS_TARGET="platform=armv"
fi

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" CC=${CC} CXX=${CXX} AR=${AR}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_pcfx_libretro.so ${INSTALL}/usr/lib/libretro/
}
