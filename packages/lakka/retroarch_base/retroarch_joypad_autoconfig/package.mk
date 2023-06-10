PKG_NAME="retroarch_joypad_autoconfig"
PKG_VERSION="91af80b8b54bfc793f470017c1962106de7a4388"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="RetroArch joypad autoconfig files"
PKG_DEPENDS_TARGET="gcc:host"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/etc/retroarch-joypad-autoconfig" DOC_DIR="${INSTALL}/etc/doc/."

  #Remove non tested joycon configs
  rm "${INSTALL}"/etc/retroarch-joypad-autoconfig/udev/Nintendo\ -\ Switch\ Pro\ Controller\ \(bare\).cfg
  rm "${INSTALL}"/etc/retroarch-joypad-autoconfig/udev/Nintendo\ -\ Switch\ Pro\ Controller.cfg
  rm "${INSTALL}"/etc/retroarch-joypad-autoconfig/udev/Nintendo-Switch-Online_NES-Controller_Left.cfg
  rm "${INSTALL}"/etc/retroarch-joypad-autoconfig/udev/Nintendo-Switch-Online_NES-Controller_Right.cfg
  rm "${INSTALL}"/etc/retroarch-joypad-autoconfig/udev/Nintendo\ Switch\ Left\ Joy-Con.cfg
  rm "${INSTALL}"/etc/retroarch-joypad-autoconfig/udev/Nintendo\ Switch\ Right\ Joy-Con.cfg
  #Place Working configs
  cp -Pr "${PKG_DIR}"/joypad_configs/* "${INSTALL}"/etc/retroarch-joypad-autoconfig/  

}

