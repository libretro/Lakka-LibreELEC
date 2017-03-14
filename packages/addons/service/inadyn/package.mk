################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-2017 Team LibreELEC
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

PKG_NAME="inadyn"
PKG_VERSION="2.1"
PKG_REV="102"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="http://troglobit.com/inadyn.html"
PKG_URL="https://github.com/troglobit/inadyn/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libconfuse libite openssl"
PKG_SECTION="service/system"
PKG_SHORTDESC="Inadyn: a small and simple Dynamic Domain Name System client"
PKG_LONGDESC="Inadyn ($PKG_VERSION) is a small and simple Dynamic Domain Name System (DDNS) client with HTTPS support. It is commonly available in many GNU/Linux distributions, used in off-the-shelf routers and Internet gateways to automate the task of keeping your DNS record up to date with any IP address changes from your ISP. It can also be used in installations with redundant (backup) connections to the Internet."
PKG_AUTORECONF="yes"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Inadyn"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

PKG_CONFIGURE_OPTS_TARGET="--enable-openssl"

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/src/inadyn $ADDON_BUILD/$PKG_ADDON_ID/bin
}
