################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
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

PKG_NAME="gamecon_gpio_rpi"
PKG_VERSION="bb65600"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/ronj/gamecon_gpio_rpi"
PKG_URL="https://github.com/ronj/gamecon_gpio_rpi/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="gamecon_gpio_rpi is a Linux kernel module which allows interfacing various retro gamepads with Raspberry Pi's GPIO"
PKG_LONGDESC="gamecon_gpio_rpi is a Linux kernel module which allows interfacing various retro gamepads with Raspberry Pi's GPIO"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make KDIR=$(kernel_path)
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
  cp *.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
}
