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

PKG_NAME="udpxy"
PKG_VERSION="1.0.23-12"
PKG_SHA256="16bdc8fb22f7659e0427e53567dc3e56900339da261199b3d00104d699f7e94c"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="http://www.udpxy.com"
PKG_URL="http://www.udpxy.com/download/1_23/${PKG_NAME}.${PKG_VERSION}-prod.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="udpxy is a UDP-to-HTTP multicast traffic relay daemon"
PKG_LONGDESC="udpxy is a UDP-to-HTTP multicast traffic relay daemon"

makeinstall_target() {
  :
}
