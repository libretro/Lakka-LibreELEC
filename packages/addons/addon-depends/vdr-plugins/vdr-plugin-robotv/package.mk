################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="vdr-plugin-robotv"
PKG_VERSION="50d4bdc"
PKG_SHA256="062489e55111f0ba2420463cc506865ac59b1c1d080b318cb81d58ec3f4fbd3f"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/pipelka/roboTV"
PKG_URL="https://github.com/pipelka/vdr-plugin-robotv/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr avahi"
PKG_SECTION="multimedia"
PKG_SHORTDESC="VDR server plugin for roboTV"
PKG_LONGDESC="RoboTV is a Android TV based frontend for VDR"
PKG_TOOLCHAIN="cmake"

pre_configure_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=$VDR_DIR:$PKG_CONFIG_PATH
  export CPLUS_INCLUDE_PATH=$VDR_DIR/include
  export VDRDIR=$VDR_DIR
}

post_make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=`sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' $VDR_DIR/config.h`
  LIB_NAME=lib${PKG_NAME/-plugin/}

  cp --remove-destination $PKG_BUILD/.$TARGET_NAME/${LIB_NAME}.so $PKG_BUILD/${LIB_NAME}.so.${VDR_APIVERSION}
}
