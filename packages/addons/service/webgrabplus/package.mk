################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="webgrabplus"
PKG_VERSION="2.1.5_beta"
PKG_SHA256="bee5d6c12bc5b62366a0d05b48c1693d715199b28b12240fa74c0b2c0f613a72"
PKG_REV="105"
PKG_ARCH="any"
PKG_LICENSE="prop."
PKG_SITE="http://www.webgrabplus.com/"
PKG_URL="http://webgrabplus.com/sites/default/files/download/SW/V2.1.5/WebGrabPlus_V2.1.5_beta_install.tar.gz"
PKG_SOURCE_DIR=".wg++"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="WebGrab+Plus: a multi-site incremental xmltv epg grabber"
PKG_LONGDESC="WebGrab+Plus ($PKG_VERSION) collects tv-program guide data from selected tvguide sites for your favourite channels."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="WebGrab+Plus"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_REQUIRES="tools.mono:0.0.0"
PKG_MAINTAINER="Anton Voyl (awiouy)"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -r $PKG_BUILD/bin $ADDON_BUILD/$PKG_ADDON_ID
}
