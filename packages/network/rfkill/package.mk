################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017 Team LibreELEC
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

PKG_NAME="rfkill"
PKG_VERSION="0.5"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://wireless.wiki.kernel.org/en/users/documentation/rfkill"
PKG_URL="https://www.kernel.org/pub/software/network/rfkill/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="network"
PKG_SHORTDESC="rfkill: userspace tool to query the state of the rfkill switches, buttons and subsystem interfaces"
PKG_LONGDESC="rfkill is a small userspace tool to query the state of the rfkill switches, buttons and subsystem interfaces."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
