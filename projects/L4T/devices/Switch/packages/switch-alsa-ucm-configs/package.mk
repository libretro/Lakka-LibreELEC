PKG_NAME="switch-alsa-ucm-configs"
PKG_DEPENDS_TARGET="alsa-lib alsa-ucm-conf"
PKG_SECTION="virtual"
PKG_LONGDESC="Nintendo Switch Alsa UCM Configs"

post_install() {
  mkdir -p ${INSTALL}/usr/share/alsa/ucm2
    cp -Prv ${PKG_DIR}/ucm_data/* ${INSTALL}/usr/share/alsa/ucm2/
  #Audio Fix Service
  enable_service alsa-init.service
}
