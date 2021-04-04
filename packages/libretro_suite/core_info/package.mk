PKG_NAME="core_info"
PKG_VERSION="baf1c40"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-core-info"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET=""
PKG_SECTION="libretro_suite"
PKG_SHORTDESC="Info files for libretro cores"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp ${PKG_BUILD}/*.info ${INSTALL}/usr/lib/libretro/
}

