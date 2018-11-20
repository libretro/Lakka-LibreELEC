# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-wirbelscan"
PKG_VERSION="2018.11.04"
PKG_SHA256="62c2848aefdb768c165310f70b3746665f57b96a95ebae96761febbb07e942e3"
PKG_LICENSE="GPL"
PKG_SITE="http://wirbel.htpc-forum.de/wirbelscan/index2.html"
PKG_URL="http://wirbel.htpc-forum.de/wirbelscan/vdr-wirbelscan-$PKG_VERSION.tgz"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_LONGDESC="Performs a channel scans for DVB-T, DVB-C and DVB-S"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  make VDRDIR=$VDR_DIR \
    LIBDIR="." \
    LOCALEDIR="./locale"
}
