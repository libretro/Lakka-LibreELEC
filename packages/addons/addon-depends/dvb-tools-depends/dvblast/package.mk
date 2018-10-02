# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvblast"
PKG_VERSION="acf3844377351ea2949ce1c48dbfde589491013d"
PKG_SHA256="007d2c93876892bd09c2a520bdce0b04f6469187123bbf24cdcf0d5effec5389"
PKG_LICENSE="GPL"
PKG_SITE="https://www.videolan.org/projects/dvblast.html"
PKG_URL="http://repo.or.cz/dvblast.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain bitstream libev"
PKG_LONGDESC="DVBlast is a simple and powerful MPEG-2/TS demux and streaming application"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -lm"
}

makeinstall_target() {
 :
}
