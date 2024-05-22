PKG_NAME="picodrive"
PKG_VERSION="695e6de85e06d47043003664531fc491eaa91240"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/irixxxx/picodrive"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ${PKG_NAME}:host"
PKG_DEPENDS_HOST="toolchain:host"
PKG_LONGDESC="Libretro implementation of PicoDrive. (Sega Megadrive/Genesis/Sega Master System/Sega GameGear/Sega CD/32X)"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro -C ../"

make_host() {
  if [ "${ARCH}" != "x86_64" ]; then
    make -C ../cpu/cyclone CONFIG_FILE=../cyclone_config.h
  fi
}

makeinstall_host() {
  : # nothing to do
}

pre_make_target() {
  CFLAGS+=" -I./"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../picodrive_libretro.so ${INSTALL}/usr/lib/libretro/
}
