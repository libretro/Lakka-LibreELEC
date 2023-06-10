PKG_NAME="switch-bsp"
PKG_VERSION=1.0"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="joycond rewritefs xdotool alsa-lib alsa-ucm-conf usb-gadget-scripts"
PKG_SECTION="virtual"
PKG_LONGDESC="LibreELEC Nintendo Switch Board Support"

post_install() {
  enable_service xorg-configure-switch.service
  enable_service var-bluetoothconfig.mount
  enable_service pair-joycon.service
  enable_service fix-permissions.service
  enable_service alsa-init.service

  mkdir -p ${INSTALL}/usr/bin
  cp -Pv ${PKG_DIR}/scripts/pair-joycon.sh ${INSTALL}/usr/bin
  cp -Pv ${PKG_DIR}/scripts/dock-hotplug ${INSTALL}/usr/bin
  cp -pv ${PKG_DIR}/scripts/fix-sysfs-permissions.sh ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/share/alsa/ucm2
    cp -Prv ${PKG_DIR}/ucm_data/* ${INSTALL}/usr/share/alsa/ucm2/

  #Fix Script Permissions
  chmod +x ${INSTALL}/usr/bin/pair-joycon.sh
  chmod +x ${INSTALL}/usr/bin/dock-hotplug
  chmod +x ${INSTALL}/usr/bin/fix-sysfs-permissions.sh
}
