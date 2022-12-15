PKG_NAME="snes9x2005_plus"
PKG_VERSION="fd45b0e055bce6cff3acde77414558784e93e7d0"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/snes9x2005"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Snes9x 2005 Plus. Port of SNES9x 1.43 for libretro (was previously called CAT SFC) with enabled BLARRG APU."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="USE_BLARGG_APU=1"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v snes9x2005_plus_libretro.so ${INSTALL}/usr/lib/libretro/
}
