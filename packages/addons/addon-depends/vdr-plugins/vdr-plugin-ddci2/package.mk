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

PKG_NAME="vdr-plugin-ddci2"
PKG_VERSION="05dd988"
PKG_SHA256="b8ed2787e9140eb00a68397eaeb14862ba88a6e73480dc3220a098faffb14833"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jasmin-j/vdr-plugin-ddci2"
PKG_URL="https://github.com/jasmin-j/vdr-plugin-ddci2/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_SECTION="multimedia"
PKG_SHORTDESC="Support for stand alone CI by Digital Devices."
PKG_LONGDESC="Support for stand alone CI by Digital Devices."
PKG_TOOLCHAIN="manual"

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

  cp --remove-destination $PKG_BUILD/${LIB_NAME}.so $PKG_BUILD/${LIB_NAME}.so.${VDR_APIVERSION}
  $STRIP libvdr-*.so*
}
