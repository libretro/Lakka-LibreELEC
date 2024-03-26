PKG_NAME="gpicase_safeshutdown"
PKG_VERSION="1.0"
PKG_ARCH="arm aarch64"
if [ "${DEVICE}" != "RPi4-GPICase2" ]; then
  # for GPICase & Pi02GPi & RPiZero2-GPiCASE2W
  PKG_DEPENDS_TARGET="Python3 gpiozero colorzero"
else
  # for RPi4-GPICase2
  PKG_DEPENDS_TARGET="Python3 RPi.GPIO"
fi
PKG_SECTION="system"
PKG_LONGDESC="GPICase safe shutdown script."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
}

post_install() {
  if [ "${DEVICE}" != "RPi4-GPICase2" ]; then
    # for GPICase & Pi02GPi & RPiZero2-GPiCASE2W
    enable_service gpicase-safeshutdown.service
    rm -v ${INSTALL}/usr/bin/safeshutdown_gpicase2.py
    rm -v ${INSTALL}/usr/lib/systemd/system/gpicase2-safeshutdown.service
  else
    # for RPi4-GPICase2
    enable_service gpicase2-safeshutdown.service
    rm -v ${INSTALL}/usr/bin/safeshutdown_gpi.py
    rm -v ${INSTALL}/usr/lib/systemd/system/gpicase-safeshutdown.service
  fi
}
