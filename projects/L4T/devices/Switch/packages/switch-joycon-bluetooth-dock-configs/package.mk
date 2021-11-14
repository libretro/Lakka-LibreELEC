PKG_NAME="switch-joycon-bluetooth-dock-configs"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="joycond rewritefs xdotool"
PKG_SECTION="virtual"
PKG_LONGDESC="Scripts for docking, and pairing joycons. Bluez config mount"

post_install() {
  enable_service xorg-configure-switch.service
  enable_service var-bluetoothconfig.mount
  enable_service pair-joycon.service

  mkdir -p ${INSTALL}/usr/bin
  cp -Pv ${PKG_DIR}/scripts/pair-joycon.sh ${INSTALL}/usr/bin
  cp -Pv ${PKG_DIR}/scripts/dock-hotplug ${INSTALL}/usr/bin
  chmod +x ${INSTALL}/usr/bin/pair-joycon.sh
  chmod +x ${INSTALL}/usr/bin/dock-hotplug

}
