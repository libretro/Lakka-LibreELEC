# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="snapcast"
PKG_VERSION="0.26.0"
PKG_SHA256="166353267a5c461a3a0e7cbd05d78c4bfdaebeda078801df3b76820b54f27683"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/badaix/snapcast"
PKG_URL="https://github.com/badaix/snapcast/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain aixlog alsa-lib asio avahi flac libvorbis popl pulseaudio boost opus"
PKG_LONGDESC="Synchronous multi-room audio player."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-sysroot"

pre_configure_target() {
  cd ..
  rm -rf .${TARGET_NAME}
  CXXFLAGS="${CXXFLAGS} -pthread \
                      -I$(get_install_dir aixlog)/usr/include \
                      -I$(get_install_dir asio)/usr/include \
                      -I$(get_install_dir popl)/usr/include"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -p server/snapserver client/snapclient ${INSTALL}/usr/bin
}
