PKG_NAME="switch-pulseaudio-configs"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="pulseaudio"
PKG_SECTION="virtual"
PKG_LONGDESC="Nintendo Switch Pulseaudio configs"

post_install() {
  mkdir -p ${INSTALL}/etc/pulse
    cp -Prv ${PKG_DIR}/pulse/* ${INSTALL}/etc/pulse/
}
