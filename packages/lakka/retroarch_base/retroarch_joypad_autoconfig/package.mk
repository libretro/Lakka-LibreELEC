PKG_NAME="retroarch_joypad_autoconfig"
PKG_VERSION="794a2f18cdb7b5c3565e75c2a663f598e3f90e24"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="RetroArch joypad autoconfig files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/etc/retroarch-joypad-autoconfig" DOC_DIR="${INSTALL}/etc/doc/."

  #Remove non tested joycon configs
  rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/Nintendo Switch Pro Controller (non-HID) (default-off).cfg"
  rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/Nintendo Switch Pro Controller.cfg"
  rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/Nintendo-Switch-Online_NES-Controller_Left.cfg"
  rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/Nintendo-Switch-Online_NES-Controller_Right.cfg"
  rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/Nintendo Switch Left Joy-Con.cfg"
  rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/Nintendo Switch Right Joy-Con.cfg"
  #Place Working configs
  cp -Prv ${PKG_DIR}/joypad_configs/* ${INSTALL}/etc/retroarch-joypad-autoconfig/

  if [ "${DEVICE}" = "RK3326" ]; then
    # remove upstream OLD configs for ODROID-GO Advance
    rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/go_advance_gamepad.cfg"
    rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/odroidgo2_joypad.cfg"
    # remove upstream OLD configs for ODROID-GO Advance Black Edition
    rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/go_advance_gamepad_v11.cfg"
    rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/odroidgo2_joypad_v11.cfg"
    # remove upstream OLD configs for ODROID-GO Super
    rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/go_super_gamepad.cfg"
    rm -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/odroidgo3_joypad.cfg"

    # workaround sha256sum warnings
    mv -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/GO-Advance_Gamepad.cfg" \
          "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/GO-Advance Gamepad.cfg"
    mv -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/GO-Advance_Gamepad_(rev_1.1).cfg" \
          "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/GO-Advance Gamepad (rev 1.1).cfg"
    mv -v "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/GO-Super_Gamepad.cfg" \
          "${INSTALL}/etc/retroarch-joypad-autoconfig/udev/GO-Super Gamepad.cfg"
  fi
}

