PKG_NAME="jumpnbump"
PKG_VERSION="5fd1a7c7757d2a73d8a49578155f0302d7794ac2"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/jumpnbump-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Jump 'n Bump."

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v jumpnbump_libretro.so ${INSTALL}/usr/lib/libretro/
}
