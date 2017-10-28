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

PKG_NAME="tvheadend"
PKG_VERSION="1.0"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service.multimedia"
PKG_SHORTDESC="Add-on removed"
PKG_LONGDESC="Add-on removed"
PKG_AUTORECONF="no"

PKG_ADDON_BROKEN="Tvheadend 4.0 is no longer maintained and has been superseded by Tvheadend 4.2."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Tvheadend Server 4.0"
PKG_ADDON_TYPE="xbmc.broken"

make_target() {
  :
}

makeinstall_target() {
  :
}

addon() {
  :
}
