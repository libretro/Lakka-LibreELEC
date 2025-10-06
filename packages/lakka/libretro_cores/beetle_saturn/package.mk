PKG_NAME="beetle_saturn"
PKG_VERSION="ccba5265f60f8e64a1984c9d14d383606193ea6a"
PKG_ARCH="x86_64"
if [ "${PROJECT}" = "RPi" ] && [ "${DEVICE}" = "RPi5" ]; then
  PKG_ARCH+=" aarch64"
fi
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
