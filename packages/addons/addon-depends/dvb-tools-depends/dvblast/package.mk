# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvblast"
PKG_VERSION="6fa5ef52443280d293e606510991917ddfbff705"
PKG_SHA256="d1d686399644e4823ae891d0a995597f23c20c47072d15ea5d5561d8b48fe64d"
PKG_LICENSE="GPL"
PKG_SITE="https://www.videolan.org/projects/dvblast.html"
PKG_URL="http://repo.or.cz/dvblast.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain bitstream libev"
PKG_LONGDESC="DVBlast is a simple and powerful MPEG-2/TS demux and streaming application"
PKG_BUILD_FLAGS="-sysroot"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -lm"
  export PREFIX="/usr"
}
