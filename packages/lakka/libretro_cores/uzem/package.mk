PKG_NAME="uzem"
PKG_VERSION="4c70043e4ad6a8a3aa6326834fba53f2b1c68699"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-uzem"
PKG_URL="${PKG_SITE}.git"
PKG_PATCH_DIRS="libretro"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A retro-minimalist game console engine for the ATMega644"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v uzem_libretro.so ${INSTALL}/usr/lib/libretro/
}
