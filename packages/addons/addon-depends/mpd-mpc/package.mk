# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpd-mpc"
PKG_VERSION="0.33"
PKG_SHA256="4f40ccbe18f5095437283cfc525a97815e983cbfd3a29e48ff610fa4f1bf1296"
PKG_LICENSE="GPL"
PKG_SITE="https://www.musicpd.org"
PKG_URL="https://www.musicpd.org/download/mpc/0/mpc-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libiconv libmpdclient"
PKG_LONGDESC="Command-line client for MPD."
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS="-sysroot"
