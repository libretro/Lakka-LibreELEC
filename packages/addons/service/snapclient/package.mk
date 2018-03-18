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

PKG_NAME="snapclient"
PKG_VERSION="0.13.0"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_DEPENDS_TARGET="toolchain snapcast"
PKG_SECTION="service"
PKG_SHORTDESC="Snapclient: Synchronous multi-room audio client"
PKG_LONGDESC="Snapclient ($PKG_VERSION) is a Snapcast client. Snapcast is a multi-room client-server audio system, where all clients are time synchronized with the server to play perfectly synced audioplays."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Snapclient"
PKG_ADDON_TYPE="xbmc.service.library"
PKG_MAINTAINER="Anton Voyl (awiouy)"

addon() {
  mkdir -p "$ADDON_BUILD/$PKG_ADDON_ID/bin"
  cp "$(get_build_dir snapcast)/client/snapclient" \
     "$ADDON_BUILD/$PKG_ADDON_ID/bin"
}
