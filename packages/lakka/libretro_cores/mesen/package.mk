PKG_NAME="mesen"
PKG_VERSION="3336a4215204010c7bcba9bafac7c4fdac0495c0"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/Mesen"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Mesen is a cross-platform (Windows & Linux) NES/Famicom emulator built in C++ and C#"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C Libretro/"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v Libretro/mesen_libretro.so ${INSTALL}/usr/lib/libretro/
}

