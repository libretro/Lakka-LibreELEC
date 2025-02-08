PKG_NAME="snes9x2005"
PKG_VERSION="74d871db9b4dba6dbe6c5ecebc88cbf255be5349"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/snes9x2005"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_LONGDESC="Snes9x 2005. Port of SNES9x 1.43 for libretro (was previously called CAT SFC)."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v snes9x2005_libretro.so ${INSTALL}/usr/lib/libretro/
}
