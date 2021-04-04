PKG_NAME="slang-shaders"
PKG_VERSION="12fdb65"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/slang-shaders"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro_suite"
PKG_SHORTDESC="Common Slang shaders for RetroArch"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/common-shaders"
}
