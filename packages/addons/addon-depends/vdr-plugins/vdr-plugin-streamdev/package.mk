################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="vdr-plugin-streamdev"
PKG_VERSION="fc52e92"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://projects.vdr-developer.org/projects/plg-streamdev"
PKG_URL="https://projects.vdr-developer.org/git/vdr-plugin-streamdev.git/snapshot/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain vdr openssl"
PKG_SECTION="multimedia"
PKG_SHORTDESC="TV"
PKG_LONGDESC="TV"

PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=$VDR_DIR:$PKG_CONFIG_PATH
  export CPLUS_INCLUDE_PATH=$VDR_DIR/include

  make \
    LIBDIR="." \
    LOCDIR="./locale" \
    all
}

post_make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=`sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' $VDR_DIR/config.h`
  LIB_NAME=lib${PKG_NAME/-plugin/}
  cp --remove-destination $PKG_BUILD/server/${LIB_NAME}-server.so $PKG_BUILD/server/${LIB_NAME}-server.so.${VDR_APIVERSION}
  cp --remove-destination $PKG_BUILD/client/${LIB_NAME}-client.so $PKG_BUILD/client/${LIB_NAME}-client.so.${VDR_APIVERSION}

  $STRIP client/libvdr-*.so*
  $STRIP server/libvdr-*.so*
}

makeinstall_target() {
  : # installation not needed, done by create-addon script
}

