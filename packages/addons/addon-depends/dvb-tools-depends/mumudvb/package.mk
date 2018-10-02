# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mumudvb"
PKG_VERSION="6153f87a17a94fbf6e71d710bef39c313302b494"
PKG_SHA256="4e8dd903d0cba1e798c3921da83b332a9bbb5ad2102f5c1a9699965af6989e28"
PKG_LICENSE="GPL"
PKG_SITE="http://mumudvb.net/"
PKG_URL="https://github.com/braice/MuMuDVB/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libdvbcsa"
PKG_LONGDESC="MuMuDVB (Multi Multicast DVB) is a program that streams from DVB on a network using multicasting or unicast"
PKG_TOOLCHAIN="autotools"

makeinstall_target() {
  :
}
