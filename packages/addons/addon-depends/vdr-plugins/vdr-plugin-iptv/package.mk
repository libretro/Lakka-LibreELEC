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

PKG_NAME="vdr-plugin-iptv"
PKG_VERSION="5ae793f"
PKG_SHA256="b7a071ff46e6e06c18e3fbc413e3c8eb2bdb6cae3af953ce93e94ab445bf5cda"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.saunalahti.fi/~rahrenbe/vdr/iptv/"
PKG_URL="https://github.com/rofafor/vdr-plugin-iptv/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr curl"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_SECTION="multimedia"
PKG_SHORTDESC="vdr-iptv: an IPTV plugin for the Video Disk Recorder (VDR)"
PKG_LONGDESC="vdr-iptv is an IPTV plugin for the Video Disk Recorder (VDR)"
PKG_TOOLCHAIN="manual"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=$VDR_DIR:$PKG_CONFIG_PATH
  export CPLUS_INCLUDE_PATH=$VDR_DIR/include

  make \
    LIBDIR="." \
    LOCDIR="./locale" \
    all install-i18n
}

post_make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=`sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' $VDR_DIR/config.h`
  LIB_NAME=lib${PKG_NAME/-plugin/}

  cp --remove-destination $PKG_BUILD/${LIB_NAME}.so $PKG_BUILD/${LIB_NAME}.so.${VDR_APIVERSION}
}
