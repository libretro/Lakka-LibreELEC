PKG_NAME="beetle_ngp"
PKG_VERSION="65460e3a9ad529f6901caf669abbda11f437ab55"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-ngp-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro implementation of Mednafen Neo Geo Pocket."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mednafen_ngp_libretro.so ${INSTALL}/usr/lib/libretro/
}
