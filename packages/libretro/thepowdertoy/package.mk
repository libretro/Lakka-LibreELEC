PKG_NAME="thepowdertoy"
PKG_VERSION="f644498"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/ThePowderToy"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A port of The Powder Toy to Libretro"
PKG_TOOLCHAIN="cmake"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp src/thepowdertoy_libretro.so $INSTALL/usr/lib/libretro/
}
