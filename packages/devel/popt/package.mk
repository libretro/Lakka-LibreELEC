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

PKG_NAME="popt"
PKG_VERSION="1.16"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://rpm5.org/files/popt/"
PKG_URL="http://rpm5.org/files/popt/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="popt: library for parsing command line options."
PKG_LONGDESC="The popt library exists essentially for parsing command-line options. It is found superior in many ways when compared to parsing the argv array by hand or using the getopt functions getopt() and getopt_long()."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"


pre_configure_target() {
 cd $PKG_BUILD
 rm -rf .$TARGET_NAME
}

pre_configure_host() {
 cd $PKG_BUILD
 rm -rf .$HOST_NAME
}
