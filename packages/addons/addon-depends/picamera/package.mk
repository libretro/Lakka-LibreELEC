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

PKG_NAME="picamera"
PKG_VERSION="1.10"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/waveform80/picamera"
PKG_URL="https://pypi.python.org/packages/source/p/picamera/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host bcm2835-driver"
PKG_PRIORITY="optional"
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
