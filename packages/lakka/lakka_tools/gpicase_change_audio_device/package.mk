PKG_NAME="gpicase_change_audio_device"
PKG_VERSION="1.0"
PKG_LICENSE="GPL"
PKG_SITE="https://www.lakka.tv"
PKG_DEPENDS_TARGET="systemd"
PKG_LONGDESC="Shell script to wget the latest update"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
}

post_install() {
  if [ "${DEVICE}" = "GPICase" -o "${DEVICE}" = "Pi02GPi" ]; then
    enable_service gpicase-change-audio_device.service
  fi
}

