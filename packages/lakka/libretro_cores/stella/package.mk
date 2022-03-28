PKG_NAME="stella"
PKG_VERSION="f4401bea92705f9c7fc63592da45afe57f4e4dcd"
PKG_LICENSE="GPL2"
PKG_SITE="https://github.com/stella-emu/stella"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Stella is a multi-platform Atari 2600 VCS emulator released under the GNU General Public License (GPL)."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../src/libretro -f Makefile"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../src/libretro/stella_libretro.so ${INSTALL}/usr/lib/libretro/
}

