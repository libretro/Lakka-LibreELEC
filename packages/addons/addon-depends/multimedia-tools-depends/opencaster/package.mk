################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
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

PKG_NAME="opencaster"
PKG_VERSION="3.2.2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.avalpa.com/the-key-values/15-free-software/33-opencaster"
PKG_URL="http://ftp.de.debian.org/debian/pool/main/o/opencaster/opencaster_${PKG_VERSION}+dfsg.orig.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="MPEG2 transport stream data generator and packet manipulator"
PKG_LONGDESC="OpenCaster is a free and open source MPEG2 transport stream data generator and packet manipulator"
PKG_AUTORECONF="no"

pre_makeinstall_target() {
  mkdir -p $PKG_BUILD/.install_pkg
}
