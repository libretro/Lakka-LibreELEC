# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-wirbelscan"
PKG_VERSION="2017.06.04"
PKG_SHA256="c7a792c794fb98dd7f665e1be2271f4a1a957a26c017043fcd4dd8d8b7fd582b"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://wirbel.htpc-forum.de/wirbelscan/index2.html"
PKG_URL="http://wirbel.htpc-forum.de/wirbelscan/${PKG_NAME/-plugin/}-dev-$PKG_VERSION.tgz"
PKG_SOURCE_DIR="wirbelscan-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_SECTION="multimedia"
PKG_SHORTDESC="Performs a channel scans for DVB-T, DVB-C and DVB-S"
PKG_LONGDESC="Performs a channel scans for DVB-T, DVB-C and DVB-S"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  cp backup/Makefile.old Makefile
  make VDRDIR=$VDR_DIR \
    LIBDIR="." \
    LOCALEDIR="./locale"
}
