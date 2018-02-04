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

PKG_NAME="w_scan"
PKG_VERSION="20170107"
PKG_SHA256="38e0f38a7bf06cff6d6ea01652ad4ee60da2cb0e937360468f936da785b46ffe"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://wirbel.htpc-forum.de/w_scan/index2.html"
PKG_URL="http://wirbel.htpc-forum.de/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="DVBlast is a small channel scan tool to create an channel.conf for VDR"
PKG_LONGDESC="DVBlast is a small channel scan tool to create an channel.conf for VDR"
PKG_TOOLCHAIN="autotools"

# aml 3.14 is meh
pre_configure_target() {
if [ $LINUX = "amlogic-3.14" -o $LINUX = "amlogic-3.10" ]; then
  sed -i 's/DVB_HEADER=0/DVB_HEADER=1/g' $PKG_BUILD/configure*
  sed -i 's/HAS_DVB_API5=0/HAS_DVB_API5=1/g' $PKG_BUILD/configure*
fi
}
