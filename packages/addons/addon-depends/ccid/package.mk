# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ccid"
PKG_VERSION="1.4.28"
PKG_SHA256="875836ac5d9d952b40dc1a253a726e74361671864d81337285a3260268f8ade0"
PKG_LICENSE="LGPL"
PKG_SITE="http://pcsclite.alioth.debian.org/ccid.html"
PKG_URL="https://alioth.debian.org/frs/download.php/latestfile/112/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain pcsc-lite"
PKG_LONGDESC="A generic USB Chip/Smart Card Interface Devices driver."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --enable-twinserial"

make_target() {
  make
  make -C src/ Info.plist
}
