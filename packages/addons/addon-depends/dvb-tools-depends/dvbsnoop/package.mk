# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvbsnoop"
PKG_VERSION="c1ec72f"
PKG_SHA256="a277434fa78a31493d53a74e2a4f5bbb77e9cc396ec230c64f03e85dc6338e7f"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://dvbsnoop.sourceforge.net/"
PKG_URL="https://github.com/persianpros/dvbsnoop/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="dvbsnoop is a DVB/MPEG stream analyzer program"
PKG_LONGDESC="dvbsnoop is a DVB/MPEG stream analyzer program"
PKG_TOOLCHAIN="autotools"

makeinstall_target() {
  :
}
