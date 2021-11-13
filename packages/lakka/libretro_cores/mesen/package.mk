PKG_NAME="mesen"
PKG_VERSION="094d82bf724448426acbaad45e83bc38994e32f6"
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

