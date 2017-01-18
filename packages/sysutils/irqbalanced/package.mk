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

PKG_NAME="irqbalanced"
PKG_VERSION="7f31046"
PKG_ARCH="arm"
PKG_LICENSE="other"
PKG_SITE="http://www.freescale.com"
PKG_URL="https://github.com/dv1/irqbalanced/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd glib"
PKG_SECTION="system"
PKG_SHORTDESC="irqbalanced: distribute hardware interrupts across processors on a multiprocessor system."
PKG_LONGDESC="irqbalanced: distribute hardware interrupts across processors on a multiprocessor system."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  sh -c ./autogen.sh
}

post_install() {
  enable_service irqbalance.service
}
