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

PKG_NAME="hddtemp"
PKG_VERSION="0.3-beta15"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.guzu.net/linux/hddtemp.php"
PKG_URL="http://download.savannah.gnu.org/releases/hddtemp/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="debug/tools"
PKG_SHORTDESC="hddtemp: tool that reports hard drive temperature"
PKG_LONGDESC="hddtemp is a small utility (daemonizable) that gives you the temperature of your hard drive by reading S.M.A.R.T. informations (for drives that support this feature)."
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--with-db-path=/storage/.kodi/addons/virtual.system-tools/data/hddtemp.db"

makeinstall_target() {
  : # nop
}

