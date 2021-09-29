PKG_NAME="mesen_s"
PKG_VERSION="42eb0e8"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/Mesen-S"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Mesen-S is a cross-platform (Windows & Linux) SNES emulator built in C++ and C#"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C Libretro/"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v Libretro/mesen-s_libretro.so ${INSTALL}/usr/lib/libretro/
}

