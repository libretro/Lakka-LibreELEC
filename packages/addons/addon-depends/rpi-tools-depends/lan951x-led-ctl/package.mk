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

PKG_NAME="lan951x-led-ctl"
PKG_VERSION="0291b91"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/dradermacher/lan951x-led-ctl"
PKG_URL="https://github.com/dradermacher/lan951x-led-ctl/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_SECTION="rpi-tools"
PKG_SHORTDESC="Control LEDs connected to LAN9512/LAN9514 ethernet USB controllers"
PKG_LONGDESC="Control LEDs connected to LAN9512/LAN9514 ethernet USB controllers"
PKG_AUTORECONF="no"

make_target() {
  $CC -std=c11 -I./include -Wall -Wstrict-prototypes -Wconversion \
      -Wmissing-prototypes -Wshadow -Wextra -Wunused \
      $CFLAGS -lusb-1.0 $LDFLAGS -o lan951x-led-ctl src/lan951x-led-ctl.c

  $STRIP lan951x-led-ctl
}

makeinstall_target() {
  : # nop
}
