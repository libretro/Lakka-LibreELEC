# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nv-codec-headers"
PKG_VERSION="12.2.72.0"
PKG_SHA256="dbeaec433d93b850714760282f1d0992b1254fc3b5a6cb7d76fc1340a1e47563"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/FFmpeg/nv-codec-headers"
PKG_URL="https://github.com/FFmpeg/nv-codec-headers/archive/n${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="FFmpeg version of headers required to interface with Nvidias codec APIs."

makeinstall_target(){
  make DESTDIR=${SYSROOT_PREFIX} PREFIX=/usr install
}
