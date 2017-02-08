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

PKG_NAME="net-snmp"
PKG_VERSION="5.7.3"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://www.net-snmp.org"
PKG_URL="http://sourceforge.net/projects/net-snmp/files/$PKG_NAME/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="Simple Network Management Protocol utilities."
PKG_LONGDESC="Simple Network Management Protocol (SNMP) is a widely used protocol for monitoring the health and welfare of network equipment."
PKG_AUTORECONF="yes"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Net-SNMP"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="--with-defaults \
        --disable-applications \
        --disable-manuals \
        --disable-debugging \
        --disable-deprecated \
        --disable-snmptrapd-subagent \
        --disable-perl-cc-checks \
        --with-perl-modules=no \
        --enable-mini-agent \
        --enable-static=no \
        --enable-shared=yes \
        --with-logfile=/storage/.kodi/userdata/addon_data/${PKG_ADDON_ID}/ \
        --with-persistent-directory=/storage/.kodi/userdata/addon_data/${PKG_ADDON_ID}/ \
        --disable-embedded-perl"

make_target() {
  make
}

makeinstall_target() {
  make install INSTALL_PREFIX=$ROOT/$PKG_BUILD/.$TARGET_NAME
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  mv $PKG_BUILD/.$TARGET_NAME/usr/sbin/snmpd $PKG_BUILD/.$TARGET_NAME/usr/bin/snmpd
  rm -rf $PKG_BUILD/.$TARGET_NAME/usr/sbin/
  rm -rf $PKG_BUILD/.$TARGET_NAME/usr/include/
  cp -r $PKG_BUILD/.$TARGET_NAME/usr/* $ADDON_BUILD/$PKG_ADDON_ID/
  $STRIP $ADDON_BUILD/$PKG_ADDON_ID/lib/*.so
  $STRIP $ADDON_BUILD/$PKG_ADDON_ID/bin/snmpd
}

