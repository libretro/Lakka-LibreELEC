PKG_NAME="pulseaudio-configs"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="pulseaudio"
PKG_SECTION="virtual"
PKG_LONGDESC="Standard configs for pulseaudio"

post_install() {
  mkdir -p ${INSTALL}/etc/pulse
    cp -Prv ${PKG_DIR}/pulse/* ${INSTALL}/etc/pulse/
    mv ${INSTALL}/etc/pulse/asound.conf ${INSTALL}/etc/
}
