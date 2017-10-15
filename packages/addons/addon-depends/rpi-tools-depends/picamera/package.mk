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

PKG_NAME="picamera"
PKG_VERSION="1.10"
PKG_SHA256="f0dfc3a6983f63da2ff7cbefeedcacb8c98cc41ad651e55148e8f798940ca73d"
PKG_ARCH="arm"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/waveform80/picamera"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host bcm2835-driver"
PKG_SECTION="python"
PKG_SHORTDESC="A python and shell interface for the Raspberry Pi camera module"
PKG_LONGDESC="A python and shell interface for the Raspberry Pi camera module"
PKG_AUTORECONF="no"

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}
