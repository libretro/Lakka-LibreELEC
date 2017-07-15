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

PKG_NAME="hid_mapper"
PKG_VERSION="2.1.0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/s-leroux/hid_mapper"
PKG_URL="https://github.com/s-leroux/hid_mapper/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="generic HID mapper"
PKG_LONGDESC="generic HID mapper"
PKG_AUTORECONF="no"

makeinstall_target() {
  : # nope
}
