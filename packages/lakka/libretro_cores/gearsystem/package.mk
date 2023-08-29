PKG_NAME="gearsystem"
PKG_VERSION="c58a865a727e6f7b83123a1a261c13bcc1b0f0dc"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/drhelius/Gearsystem"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Gearsystem is a Sega Master System / Game Gear / SG-1000 emulator written in C++"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C platforms/libretro/"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v platforms/libretro/gearsystem_libretro.so ${INSTALL}/usr/lib/libretro/
}

