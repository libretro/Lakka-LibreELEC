PKG_NAME="beetle_saturn"
PKG_VERSION="ae30f29e340a00b33e38df85ceaa599151a47cd7"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-saturn-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Standalone port of Mednafen Saturn to libretro."
PKG_LONGDESC="Standalone port of Mednafen Saturn to libretro."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="HAVE_CDROM=1"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_saturn_libretro.so ${INSTALL}/usr/lib/libretro/
}
