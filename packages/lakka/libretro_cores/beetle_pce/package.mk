PKG_NAME="beetle_pce"
PKG_VERSION="af28fb0385d00e0292c4703b3aa7e72762b564d2"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-pce-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Standalone port of Mednafen PCE to libretro."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="HAVE_CDROM=1"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_pce_libretro.so ${INSTALL}/usr/lib/libretro/
}
