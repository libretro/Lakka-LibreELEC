PKG_NAME="applewin"
PKG_VERSION="e60c398c1ea08426d01d69c200e057372f237468"
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://github.com/audetto/AppleWin"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Apple II emulator for Linux"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DBUILD_LIBRETRO=ON"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v source/frontends/libretro/applewin_libretro.so ${INSTALL}/usr/lib/libretro/
}
