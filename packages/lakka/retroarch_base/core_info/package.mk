PKG_NAME="core_info"
PKG_VERSION="3d9b20d3711c8c2827246e3b48a503973192f080"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-core-info"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Info files for libretro cores"
PKG_DEPENDS_TARGET="gcc:host"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/lib/libretro"
}

