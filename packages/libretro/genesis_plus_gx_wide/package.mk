PKG_NAME="genesis_plus_gx_wide"
PKG_VERSION="73c298b"
PKG_ARCH="any"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/Genesis-Plus-GX-Wide"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Genesis Plus GX is an open-source & portable Sega Mega Drive / Genesis emulator, now also emulating SG-1000, Master System, Game Gear and Sega/Mega CD hardware."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

pre_make_target() {
  if [ "$ARCH" = "arm" -o "$ARCH" = "aarch64" ]; then
    CFLAGS+=" -DALIGN_LONG"
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp genesis_plus_gx_wide_libretro.so $INSTALL/usr/lib/libretro/genesis_plus_gx_wide_libretro.so
}
