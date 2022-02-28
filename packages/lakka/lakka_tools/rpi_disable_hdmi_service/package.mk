PKG_NAME="rpi_disable_hdmi_service"
PKG_VERSION="1.0"
PKG_LICENSE="GPL"
PKG_SITE="https://www.lakka.tv"
PKG_DEPENDS_TARGET="systemd"
PKG_LONGDESC="Package to install a service"
PKG_TOOLCHAIN="manual"

post_install() {
  if [ "${PROJECT}" = "RPi" ] && [ "${DEVICE}" = "GPICase" -o "${DEVICE}" = "Pi02GPi" ]; then
    enable_service disable-hdmi.service
  fi
}
