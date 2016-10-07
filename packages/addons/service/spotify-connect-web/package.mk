################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="spotify-connect-web"
PKG_VERSION="0.0.3-alpha"
PKG_REV="103"
PKG_ARCH="arm"
PKG_ADDON_PROJECTS="RPi2 WeTek_Core WeTek_Play"
PKG_LICENSE="prop."
PKG_SITE="https://github.com/Fornoth/spotify-connect-web"
PKG_URL="https://github.com/Fornoth/spotify-connect-web/releases/download/$PKG_VERSION/${PKG_NAME}_$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="spotify-connect-web"
PKG_DEPENDS_TARGET="toolchain avahi"
PKG_SECTION="service"
PKG_SHORTDESC="Spotify Connect Web: play Spotify through LibreELEC"
PKG_LONGDESC="Spotify Connect Web ($PKG_VERSION) plays Spotify through LibreELEC, using a Spotify app as a remote."
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Spotify Connect Web"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin

  cp -P $(get_build_dir avahi)/avahi-utils/.libs/avahi-publish \
        $ADDON_BUILD/$PKG_ADDON_ID/bin/

  cp -PR $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID/
  rm $ADDON_BUILD/$PKG_ADDON_ID/libasound.so.2
}
