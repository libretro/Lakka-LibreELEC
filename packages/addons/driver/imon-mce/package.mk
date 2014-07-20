################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="imon-mce"
PKG_VERSION="4.3"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="driver/remote"
PKG_SHORTDESC="imon-mce: a driver to add support for MCE remotes to the imon driver"
PKG_LONGDESC="imon-mce is a driver to add support for MCE remotes to the imon driver. To readd imon remote support uninstall or disable this addon again."

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.service"

PKG_AUTORECONF="no"

make_target() {
  : # nothing to do here
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  : # nothing to do here
}
