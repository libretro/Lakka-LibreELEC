PKG_NAME="usb-gadget-scripts"
PKG_VERSION="2.0"
PKG_DEPENDS_TARGET="umtp-responder"
PKG_SHORTDESC="Nintendo Switch USB Gadget scripts, and configs"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/{usr/bin,usr/lib/systemd/system/}
    cp ${PKG_DIR}/assets/usb-gadget.sh ${INSTALL}/usr/bin/
    sed -i "s/@DISTRO@/${DISTRO}/g" ${INSTALL}/usr/bin/usb-gadget.sh
    chmod +x ${INSTALL}/usr/bin/usb-gadget.sh
    cp ${PKG_DIR}/system.d/*.service ${INSTALL}/usr/lib/systemd/system/

  #Enable Services
  enable_service usb-gadget-setup.service
 }

