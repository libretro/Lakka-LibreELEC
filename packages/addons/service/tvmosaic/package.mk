################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="tvmosaic"
PKG_VERSION="1.0.0-16296"
PKG_SHA256="63d48e7b0912f2efb6e894252a13d8312679cdcb155ebe3fa758dc88b4f91816"
PKG_REV="100"
PKG_ARCH="arm"
PKG_LICENSE="Prop."
PKG_SITE="https://tv-mosaic.com"
PKG_URL="https://github.com/awiouy/tvmosaic/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="TV Mosaic"
PKG_LONGDESC="TV Mosaic ($PKG_VERSION) live and recorded TV for Kodi and DLNA clients"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-strip"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="TV Mosaic"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp $PKG_BUILD/tvmosaic/tvmosaic_reg \
       $PKG_BUILD/tvmosaic/tvmosaic_server \
       $PKG_BUILD/tvmosaic/version.dat \
       $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/shared.inst/RecordedTV \
           $ADDON_BUILD/$PKG_ADDON_ID/config/shared.inst/channel_logo \
           $ADDON_BUILD/$PKG_ADDON_ID/config/shared.inst/xmltv
    cp -r $PKG_BUILD/tvmosaic/data \
          $PKG_BUILD/tvmosaic/shared.inst \
          $ADDON_BUILD/$PKG_ADDON_ID/config
    echo $PKG_REV > $ADDON_BUILD/$PKG_ADDON_ID/config/pkg_rev

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
    cp -L $PKG_BUILD/tvmosaic/lib/libcares.so.2 \
          $PKG_BUILD/tvmosaic/lib/libdvbapi.so \
          $PKG_BUILD/tvmosaic/lib/libdvben50221.so \
          $PKG_BUILD/tvmosaic/lib/libiconv.so.2 \
          $PKG_BUILD/tvmosaic/lib/libidn.so.11 \
          $PKG_BUILD/tvmosaic/lib/libssh2.so.1 \
          $PKG_BUILD/tvmosaic/lib/libucsi.so \
          $ADDON_BUILD/$PKG_ADDON_ID/lib
}
