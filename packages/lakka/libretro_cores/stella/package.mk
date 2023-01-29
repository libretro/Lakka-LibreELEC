PKG_NAME="stella"
PKG_VERSION="07e0d35339590a78df8e8f29e07784f8ef7a7b18"
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

