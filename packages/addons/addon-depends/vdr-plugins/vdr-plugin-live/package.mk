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

PKG_NAME="vdr-plugin-live"
PKG_VERSION="e582514"
PKG_SHA256="74deb2ca43ffb5779b3f9ff6f34c8b53898a226fcf92605d7ede0401cb62601c"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://live.vdr-developer.org/en/index.php"
PKG_URL="https://github.com/vdr-projects/vdr-plugin-live/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="$PKG_NAME-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain vdr tntnet pcre:host pcre"
PKG_SECTION="multimedia"
PKG_SHORTDESC="vdr-live: the LIVE Interactive VDR Environment/"
PKG_LONGDESC="vdr-live allows a comfortable operation of VDR and some of its plugins trough a web interface"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -L$SYSROOT_PREFIX/usr/lib/iconv"
}

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export CPLUS_INCLUDE_PATH=$VDR_DIR/include
  VDR_APIVERSION=`sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' $VDR_DIR/config.h`
  LIB_NAME=lib${PKG_NAME/-plugin/}

  make VDRDIR=$VDR_DIR \
    LIBDIR="." \
    LOCALEDIR="./locale"

  cp --remove-destination $PKG_BUILD/${LIB_NAME}.so $PKG_BUILD/${LIB_NAME}.so.${VDR_APIVERSION}
}
