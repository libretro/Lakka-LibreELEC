PKG_NAME="retroflag_picase_safeshutdown"
PKG_VERSION="1.0"
PKG_ARCH="aarch64"
PKG_DEPENDS_TARGET="Python3 lg-gpio"
PKG_SECTION="system"
PKG_LONGDESC="RETROFLAG Pi CASE series safe shutdown script."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  # service
  mkdir -p "${INSTALL}/usr/lib/systemd/system"
    cp -av "${PKG_DIR}/system.d/retroflag_picase_safeshutdown.service" "${INSTALL}/usr/lib/systemd/system"

  # script
  mkdir -p "${INSTALL}/usr/bin"
    cp -av "${PKG_DIR}/scripts/retroflag_picase_safeshutdown.py" "${INSTALL}/usr/bin"
}
