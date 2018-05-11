################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="smartmontools"
PKG_VERSION="6.6"
PKG_SHA256="51f43d0fb064fccaf823bbe68cf0d317d0895ff895aa353b3339a3b316a53054"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.smartmontools.org"
PKG_URL="https://github.com/smartmontools/smartmontools/releases/download/RELEASE_${PKG_VERSION//./_}/smartmontools-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_LONGDESC="Control and monitor storage systems using S.M.A.R.T."

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
                           --without-initscriptdir \
                           --without-nvme-devicescan \
                           --without-systemdenvfile \
                           --without-systemdsystemunitdir \
                           --without-systemdenvfile \
                           --without-systemdsystemunitdir"

makeinstall_target() {
  :
}
