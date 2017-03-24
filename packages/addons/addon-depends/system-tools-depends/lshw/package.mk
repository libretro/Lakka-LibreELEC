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

PKG_NAME="lshw"
PKG_VERSION="B.02.17"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://ezix.org/project/wiki/HardwareLiSter"
PKG_URL="http://ezix.org/software/files/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="lshw (Hardware Lister)"
PKG_LONGDESC="lshw (Hardware Lister) is a small tool to provide detailed information on the hardware configuration of the machine."
PKG_AUTORECONF="no"

make_target() {
  make CXX=$CXX -C src/
}

makeinstall_target() {
  : # nop
}
