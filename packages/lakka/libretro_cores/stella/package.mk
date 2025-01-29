PKG_NAME="stella"
PKG_VERSION="01c8a87e19ae49c1bab44947a281ecfe2b7957da"
PKG_LICENSE="GPL2"
PKG_SITE="https://github.com/stella-emu/stella"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Stella is a multi-platform Atari 2600 VCS emulator released under the GNU General Public License (GPL)."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../src/os/libretro -f Makefile"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../src/os/libretro/stella_libretro.so ${INSTALL}/usr/lib/libretro/
}

