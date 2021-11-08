PKG_NAME="retroarch_overlays"
PKG_VERSION="c03deff"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/common-overlays"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Collection of overlay files for use with libretro frontends, such as RetroArch."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/retroarch-overlays
    cp -vr ${PKG_BUILD}/* ${INSTALL}/usr/share/retroarch-overlays
}
