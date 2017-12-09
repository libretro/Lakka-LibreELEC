################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="nss-mdns"
PKG_VERSION="47edc38"
PKG_SHA256="f02e8baeceea30e82a2ecdaa8cafdbcabfdaa33a766f6942e7dc8aa81948f7b6"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lathiat/nss-mdns"
PKG_URL="https://github.com/lathiat/nss-mdns/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain avahi"
PKG_SECTION="network"
PKG_SHORTDESC="nss-mdns is a plugin for nss to allow name resolution via Multicast DNS."
PKG_LONGDESC="nss-mdns is a plugin for the GNU Name Service Switch (NSS) functionality of the GNU C Library (glibc) providing host name resolution via Multicast DNS"
PKG_TOOLCHAIN="autotools"

post_makeinstall_target() {
  mkdir -p $INSTALL/etc
  cp $PKG_DIR/config/nsswitch.conf $INSTALL/etc/nsswitch.conf
}
