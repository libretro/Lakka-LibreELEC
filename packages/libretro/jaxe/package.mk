PKG_NAME="jaxe"
PKG_VERSION="e03ea87"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/kurtjd/jaxe"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A fully-featured, cross platform XO-CHIP/S-CHIP/CHIP-8 emulator"
PKG_TOOLCHAIN="make"
PKG_MAKE_OPTS_TARGET="-f Makefile.libretro -C ../"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp ../jaxe_libretro.so $INSTALL/usr/lib/libretro/
}
