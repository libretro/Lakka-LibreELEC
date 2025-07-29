PKG_NAME="virtualxt"
PKG_VERSION="50519a28e43ca558526f81f68793506c5094c9af"
PKG_LICENSE="zlib"
# temporarily disable on arm because build failure is occurred.
# https://github.com/virtualxt/virtualxt/issues/97
# please enable (remove "!arm" in PKG_ARCH ) when build failure is fixed.
PKG_ARCH="any !arm"
PKG_SITE="https://github.com/virtualxt/virtualxt"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Lightweight Turbo PC/XT emulator."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C tools/package/libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v tools/package/libretro/virtualxt_libretro.so ${INSTALL}/usr/lib/libretro/
}
