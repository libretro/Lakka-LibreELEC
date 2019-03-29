# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpd-mpc"
PKG_VERSION="0.31"
PKG_SHA256="62373e83a8a165b2ed43967975efecd3feee530f4557d6b861dd08aa89d52b2d"
PKG_LICENSE="GPL"
PKG_SITE="https://www.musicpd.org"
PKG_URL="https://www.musicpd.org/download/mpc/0/mpc-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libiconv libmpdclient"
PKG_LONGDESC="Command-line client for MPD."
PKG_TOOLCHAIN="meson"

makeinstall_target() {
  :
}
