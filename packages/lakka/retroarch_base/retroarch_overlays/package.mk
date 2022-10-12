PKG_NAME="retroarch_overlays"
PKG_VERSION="db9744f4e58a740f0f10b04b62af347cd6f01928"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/common-overlays"
PKG_URL="https://github.com/libretro/common-overlays/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Collection of overlay files for use with libretro frontends, such as RetroArch."
PKG_DEPENDS_TARGET="gcc:host"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/overlays"
}
