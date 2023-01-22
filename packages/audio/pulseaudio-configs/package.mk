PKG_NAME="pulseaudio-configs"
PKG_VERSION="1.1"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="alsa-plugins pulseaudio"
PKG_LONGDESC="Standard configs for pulseaudio"
PKG_TOOLCHAIN="manual"

make_target() {
  mkdir -p ${PKG_BUILD}/install_target/etc/pulse
    cp -r ${PKG_DIR}/pulse/* ${PKG_BUILD}/install_target/etc/pulse/
    mv ${PKG_BUILD}/install_target/etc/pulse/asound.conf ${PKG_BUILD}/install_target/etc/
}

makeinstall_target() {
  if [ ! -d "${INSTALL}" ]; then
    mkdir -p ${INSTALL}
  fi
  echo ${INSTALL}
  cp -r ${PKG_BUILD}/install_target/* ${INSTALL}/
}
