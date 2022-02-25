PKG_NAME="jumpnbump"
PKG_VERSION="57262c7b0e7cde26e3446743bee06a431a1bb759"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/jumpnbump-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Jump 'n Bump."

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v jumpnbump_libretro.so ${INSTALL}/usr/lib/libretro/
}
