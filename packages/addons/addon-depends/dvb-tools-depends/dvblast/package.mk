# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvblast"
PKG_VERSION="77cfaa8"
PKG_SHA256="b78eaec73addb328384bf8acb93a1b6a6334f4fa47914f98b91b4cd4fc00b639"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.videolan.org/projects/dvblast.html"
PKG_URL="http://repo.or.cz/dvblast.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain bitstream libev"
PKG_SECTION="tools"
PKG_SHORTDESC="DVBlast is a simple and powerful MPEG-2/TS demux and streaming application"
PKG_LONGDESC="DVBlast is a simple and powerful MPEG-2/TS demux and streaming application"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -lm"
}

makeinstall_target() {
 :
}
