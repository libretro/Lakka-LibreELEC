################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-     Team LibreELEC
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

PKG_NAME="virtual"
PKG_VERSION=""
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="qemu:host"
PKG_SECTION="virtual"
PKG_SHORTDESC="virtual: Meta package to install Virtual project extra deps"
PKG_LONGDESC="virtual is a Meta package to install Virtual project extra dependencies"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

get_graphicdrivers

for drv in $GRAPHIC_DRIVERS; do
  if [ "$drv" = "vmware" ]; then
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET open-vm-tools"
  fi
done
