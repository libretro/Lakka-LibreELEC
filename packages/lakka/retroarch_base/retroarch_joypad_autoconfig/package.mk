PKG_NAME="retroarch_joypad_autoconfig"
PKG_VERSION="b8557bf"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="RetroArch joypad autoconfig files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/etc/retroarch-joypad-autoconfig" DOC_DIR="${INSTALL}/etc/doc/."
}
