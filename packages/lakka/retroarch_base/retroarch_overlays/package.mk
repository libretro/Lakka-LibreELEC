PKG_NAME="retroarch_overlays"
PKG_VERSION="b3827a2c63834ed9e1902acc7cf9019f64771ed3"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/common-overlays"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Collection of overlay files for use with libretro frontends, such as RetroArch."
PKG_DEPENDS_TARGET="gcc:host"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/overlays"
}
