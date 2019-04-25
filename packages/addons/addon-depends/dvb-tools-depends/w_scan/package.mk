# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="w_scan"
PKG_VERSION="20170107"
PKG_SHA256="38e0f38a7bf06cff6d6ea01652ad4ee60da2cb0e937360468f936da785b46ffe"
PKG_LICENSE="GPL"
PKG_SITE="http://wirbel.htpc-forum.de/w_scan/index2.html"
PKG_URL="http://wirbel.htpc-forum.de/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A channel scan tool which generates ATSC, DVB-C, DVB-S/S2 and DVB-T channels.conf files."
PKG_TOOLCHAIN="autotools"

makeinstall_target() {
  :
}
