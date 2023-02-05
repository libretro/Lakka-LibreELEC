PKG_NAME="switch-joycon-bluetooth-dock-configs"
PKG_VERSION=2.0
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="joycond rewritefs xdotool"
PKG_SECTION="virtual"
PKG_LONGDESC="Scripts for docking, and pairing joycons. Bluez config mount"

post_install() {
  enable_service xorg-configure-switch.service
  enable_service var-bluetoothconfig.mount
  enable_service pair-joycon.service
  enable_service fix-permissions.service

  mkdir -p ${INSTALL}/usr/bin
  cp -Pv ${PKG_DIR}/scripts/pair-joycon.sh ${INSTALL}/usr/bin
  cp -Pv ${PKG_DIR}/scripts/dock-hotplug ${INSTALL}/usr/bin
  cp -pv ${PKG_DIR}/scripts/fix-sysfs-permissions.sh ${INSTALL}/usr/bin
  chmod +x ${INSTALL}/usr/bin/pair-joycon.sh
  chmod +x ${INSTALL}/usr/bin/dock-hotplug
  chmod +x ${INSTALL}/usr/bin/fix-sysfs-permissions.sh
}
