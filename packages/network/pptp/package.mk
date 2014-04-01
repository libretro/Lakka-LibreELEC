################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="pptp"
PKG_VERSION="1.8.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://pptpclient.sourceforge.net"
PKG_URL="$SOURCEFORGE_SRC/project/pptpclient/pptp/$PKG_NAME-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ppp"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="pptp: a Linux, FreeBSD, NetBSD and OpenBSD client for the proprietary Microsoft Point-to-Point Tunneling Protocol, PPTP"
PKG_LONGDESC="PPTP Client is a Linux, FreeBSD, NetBSD and OpenBSD client for the proprietary Microsoft Point-to-Point Tunneling Protocol, PPTP. Allows connection to a PPTP based Virtual Private Network (VPN)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make PPPD="/usr/sbin/pppd" \
       IP="/sbin/ip" \
       CC="$CC" \
       CFLAGS="$CFLAGS" \
       LDFLAGS="$LDFLAGS" \
       config.h pptp
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/sbin
    cp -P pptp $INSTALL/usr/sbin
}