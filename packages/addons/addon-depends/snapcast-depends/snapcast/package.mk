# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="snapcast"
PKG_VERSION="0.15.0"
PKG_SHA256="7c584fad4941a299339fe060174e33c4d810b1cbe80d6efbee54da3dafb252cc"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/badaix/snapcast"
PKG_URL="https://github.com/badaix/snapcast/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain aixlog alsa-lib asio avahi flac libvorbis popl"
PKG_LONGDESC="Synchronous multi-room audio player."
PKG_TOOLCHAIN="make"

pre_configure_target() {
  cd ..
  rm -rf .$TARGET_NAME
  CXXFLAGS="$CXXFLAGS -pthread \
                      -I$(get_build_dir aixlog)/include \
                      -I$(get_build_dir asio)/asio/include \
                      -I$(get_build_dir popl)/include"
}

makeinstall_target() {
  :
}
