PKG_NAME="beetle_ngp"
PKG_VERSION="f969af2b52f20642aea7e800e3cfcce728f3aee9"
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
