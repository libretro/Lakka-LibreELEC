PKG_NAME="genesis_plus_gx"
PKG_VERSION="f9f16d7a552c5606caea52c2179ca2831b8e0177"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/ekeeke/Genesis-Plus-GX"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Genesis Plus GX is an open-source & portable Sega Mega Drive / Genesis emulator, now also emulating SG-1000, Master System, Game Gear and Sega/Mega CD hardware."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

if [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" NO_OPTIMIZE=1"
fi

pre_make_target() {
  if [ "${ARCH}" = "arm" -o "${ARCH}" = "aarch64" ]; then
    CFLAGS+=" -DALIGN_LONG"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v genesis_plus_gx_libretro.so ${INSTALL}/usr/lib/libretro/
}
