# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="snapcast"
PKG_VERSION="0.22.0"
PKG_SHA256="b5156f346c32557bc1347c81fd5071fd4a32be61adc582e63323c11b105c9ff6"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/badaix/snapcast"
PKG_URL="https://github.com/badaix/snapcast/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain aixlog alsa-lib asio avahi flac libvorbis popl boost opus"
PKG_LONGDESC="Synchronous multi-room audio player."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-sysroot"

pre_configure_target() {
  cd ..
  rm -rf .$TARGET_NAME
  CXXFLAGS="$CXXFLAGS -pthread \
                      -I$(get_install_dir aixlog)/usr/include \
                      -I$(get_install_dir asio)/usr/include \
                      -I$(get_install_dir popl)/usr/include"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp -p server/snapserver client/snapclient $INSTALL/usr/bin
}
