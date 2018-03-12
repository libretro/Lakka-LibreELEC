################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="vdr-plugin-wirbelscancontrol"
PKG_VERSION="0.0.2"
PKG_SHA256="178c5768dd47355a42409a2cb2629f0762da1297865e3a84963684649145cb13"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://wirbel.htpc-forum.de/wirbelscancontrol/index2.html"
PKG_URL="http://wirbel.htpc-forum.de/wirbelscancontrol/${PKG_NAME/-plugin/}-$PKG_VERSION.tgz"
PKG_SOURCE_DIR="wirbelscancontrol-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain vdr vdr-plugin-wirbelscan"
PKG_SECTION="multimedia"
PKG_SHORTDESC="Adds menu entry for wirbelscan at VDR."
PKG_LONGDESC="Adds menu entry for wirbelscan at VDR."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic"

pre_build_target() {
  WIRBELSCAN_DIR=$(get_build_dir vdr-plugin-wirbelscan)
  ln -sf $WIRBELSCAN_DIR/wirbelscan_services.h $PKG_BUILD
}

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  make VDRDIR=$VDR_DIR \
    LIBDIR="." \
    LOCALEDIR="./locale"
}
