PKG_NAME="vbam"
PKG_VERSION="d014ebd2b25362534064637907e4ce374282a098"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/visualboyadvance-m/visualboyadvance-m"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="VBA-M with libretro integration"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../src/libretro/"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../src/libretro/vbam_libretro.so ${INSTALL}/usr/lib/libretro/
}
