PKG_NAME="retroflag_picase_safeshutdown"
PKG_VERSION="1.0"
PKG_ARCH="aarch64"
PKG_DEPENDS_TARGET="Python3 lg-gpio"
PKG_SECTION="system"
PKG_LONGDESC="RETROFLAG Pi CASE series safe shutdown script."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/bin"
    if [ "${DEVICE}" = "RPi3" -o "${DEVICE}" = "RPi4" ]; then
      cp -av "${PKG_DIR}/scripts/retroflag_picase_safeshutdown.py" "${INSTALL}/usr/bin"
      cp -av "${PKG_DIR}/scripts/retroflag_picase_check_gpio-poweroff_overlay.sh" "${INSTALL}/usr/bin"
      cp -av "${PKG_DIR}/scripts/retroflag_picase_install_gpio-poweroff_overlay.sh" "${INSTALL}/usr/bin"
    elif [ "${DEVICE}" = "RPi5" ]; then
      cp -av "${PKG_DIR}/scripts/retroflag_picase_safeshutdown_pi5.py" "${INSTALL}/usr/bin"
    fi
}

post_install() {
  if [ "${DEVICE}" = "RPi3" -o "${DEVICE}" = "RPi4" ]; then
    enable_service retroflag_picase_safeshutdown.service
  elif [ "${DEVICE}" = "RPi5" ]; then
    enable_service retroflag_picase_safeshutdown_pi5.service
  fi
}
