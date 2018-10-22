# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpd-mpc"
PKG_VERSION="0.30"
PKG_SHA256="65fc5b0a8430efe9acbe6e261127960682764b20ab994676371bdc797d867fce"
PKG_LICENSE="GPL"
PKG_SITE="https://www.musicpd.org"
PKG_URL="https://www.musicpd.org/download/mpc/0/mpc-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libiconv"
PKG_LONGDESC="Command-line client for MPD."
PKG_TOOLCHAIN="meson"

makeinstall_target() {
  :
}
