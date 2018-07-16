# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mumudvb"
PKG_VERSION="a09373d"
PKG_SHA256="66ef8f11a0e5795cd6408e33581a95de88a76d499e8a0d41f34880295d346efa"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://mumudvb.net/"
PKG_URL="https://github.com/braice/MuMuDVB/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="MuMuDVB-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain libdvbcsa"
PKG_SECTION="tools"
PKG_SHORTDESC="MuMuDVB (Multi Multicast DVB) is a program that streams from DVB on a network using multicasting or unicast"
PKG_LONGDESC="MuMuDVB (Multi Multicast DVB) is a program that streams from DVB on a network using multicasting or unicast"
PKG_TOOLCHAIN="autotools"

makeinstall_target() {
  :
}
