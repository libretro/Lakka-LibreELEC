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

PKG_NAME="gpiozero"
PKG_VERSION="1.2.0"
PKG_SHA256="7e6ad5ecd6ec8e908cc16dbb655c77cdf9f68551e954754f6d02fc926113584d"
PKG_ARCH="arm"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/RPi-Distro/python-gpiozero"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="python"
PKG_SHORTDESC="A simple interface to everyday GPIO components used with Raspberry Pi"
PKG_LONGDESC="A simple interface to everyday GPIO components used with Raspberry Pi"
PKG_AUTORECONF="no"

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}
