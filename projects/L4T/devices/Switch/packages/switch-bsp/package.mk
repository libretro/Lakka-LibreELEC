PKG_NAME="switch-bsp"
PKG_VERSION="1.3"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="joycond rewritefs xdotool alsa-lib alsa-ucm-conf usb-gadget-scripts"
PKG_SECTION="virtual"
PKG_LONGDESC="LibreELEC Nintendo Switch Board Support"

if [ ! "${DISTRO}" = "LibreELEC" ]; then
  PKG_DEPENDS_TARGET+=" mergerfs v4l-utils" # We use this for CEC in lakka, in libreELEC kodi handles that via libCEC.
else
  PKG_DEPENDS_TARGET+=" polkit"
fi

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

  #fix dbus shutdown/reboot permissions.
  if [  "${DISTRO}" = "LibreELEC" ]; then
    mkdir -p ${INSTALL}/etc/polkit-1/rules.d
    cp -Pv ${PKG_DIR}/polkit.d/01-shutdown-hibernate-suspend-permissions.rules ${INSTALL}/etc/polkit-1/rules.d
    sed -i "s/@DISTRO@/${DISTRO}/g" ${INSTALL}/etc/polkit-1/rules.d/01-shutdown-hibernate-suspend-permissions.rules
  fi
}
