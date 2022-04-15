PKG_NAME="a5200"
PKG_VERSION="599a2e5"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/a5200"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Libretro port of Atari 5200 emulator version 2.0.2 for GCW0"
PKG_LONGDESC="Libretro port of Atari 5200 emulator version 2.0.2 for GCW0"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp a5200_libretro.so $INSTALL/usr/lib/libretro/
}
