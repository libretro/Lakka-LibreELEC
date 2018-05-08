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

PKG_NAME="vdr-plugin-epgsearch"
PKG_VERSION="84b59b8"
PKG_SHA256="d6c4a9136588a7cdf2eb43b6b9643a5bb81a44c542c6e6fcf7448b2383901914"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://winni.vdr-developer.org/epgsearch/"
PKG_URL="https://github.com/vdr-projects/vdr-plugin-epgsearch/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_SECTION="multimedia"
PKG_SHORTDESC="EPGSearch is a plugin for the Video-Disc-Recorder (VDR)."
PKG_LONGDESC="EPGSearch is a plugin for the Video-Disc-Recorder (VDR)."
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
