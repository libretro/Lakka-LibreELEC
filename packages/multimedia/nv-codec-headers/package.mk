# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nv-codec-headers"
PKG_VERSION="12.1.14.0"
PKG_SHA256="2fefaa227d2a3b4170797796425a59d1dd2ed5fd231db9b4244468ba327acd0b"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/FFmpeg/nv-codec-headers"
PKG_URL="https://github.com/FFmpeg/nv-codec-headers/archive/n${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="FFmpeg version of headers required to interface with Nvidias codec APIs."

makeinstall_target(){
  make DESTDIR=${SYSROOT_PREFIX} PREFIX=/usr install
}
