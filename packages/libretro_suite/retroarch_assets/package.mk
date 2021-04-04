PKG_NAME="retroarch_assets"
PKG_VERSION="52ab089"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-assets"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro_suite"
PKG_SHORTDESC="RetroArch assets. Background and icon themes for the menu drivers."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch-assets"
}
