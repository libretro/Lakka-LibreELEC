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

PKG_NAME="vdr-plugin-wirbelscan"
PKG_VERSION="2017.06.04"
PKG_SHA256="c7a792c794fb98dd7f665e1be2271f4a1a957a26c017043fcd4dd8d8b7fd582b"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://wirbel.htpc-forum.de/wirbelscan/index2.html"
PKG_URL="http://wirbel.htpc-forum.de/wirbelscan/${PKG_NAME/-plugin/}-dev-$PKG_VERSION.tgz"
PKG_SOURCE_DIR="wirbelscan-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain vdr"
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
