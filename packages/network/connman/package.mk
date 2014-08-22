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

PKG_NAME="connman"
PKG_VERSION="1.25"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.connman.net"
PKG_URL="https://www.kernel.org/pub/linux/network/connman/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib readline dbus iptables wpa_supplicant ntp"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="connman: Network manager daemon"
PKG_LONGDESC="The ConnMan project provides a daemon for managing internet connections within embedded devices running the Linux operating system. The Connection Manager is designed to be slim and to use as few resources as possible, so it can be easily integrated. It is a fully modular system that can be extended, through plug-ins, to support all kinds of wired or wireless technologies. Also, configuration methods, like DHCP and domain name resolving, are implemented using plug-ins. The plug-in approach allows for easy adaption and modification for various use cases."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

if [ "$PPTP_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET ppp pptp"
  CONNMAN_PPTP="--enable-pptp PPPD=/usr/sbin/pppd PPTP=/usr/sbin/pptp"
else
  CONNMAN_PPTP="--disable-pptp"
fi

if [ "$OPENVPN_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET openvpn"
  CONNMAN_OPENVPN="--enable-openvpn --with-openvpn=/usr/sbin/openvpn"
else
  CONNMAN_OPENVPN="--disable-openvpn"
fi

PKG_CONFIGURE_OPTS_TARGET="WPASUPPLICANT=/usr/bin/wpa_supplicant \
                           --disable-gtk-doc \
                           --disable-debug \
                           --disable-hh2serial-gps \
                           --disable-openconnect \
                           $CONNMAN_OPENVPN \
                           --disable-vpnc \
                           --disable-l2tp \
                           $CONNMAN_PPTP \
                           --disable-iospm \
                           --disable-tist \
                           --disable-session-policy-local \
                           --disable-test \
                           --disable-nmcompat \
                           --disable-polkit \
                           --disable-selinux \
                           --enable-loopback \
                           --enable-ethernet \
                           --disable-gadget \
                           --enable-wifi \
                           --disable-bluetooth \
                           --disable-ofono \
                           --disable-dundee \
                           --disable-pacrunner \
                           --disable-neard \
                           --disable-wispr \
                           --disable-tools \
                           --enable-client \
                           --enable-datafiles \
                           --disable-silent-rules"


PKG_MAKE_OPTS_TARGET="storagedir=/storage/.cache/connman \
                      vpn_storagedir=/storage/.config/vpn-config \
                      statedir=/run/connman"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/systemd

  mkdir -p $INSTALL/usr/bin
    cp -P client/connmanctl $INSTALL/usr/bin
    cp -P $PKG_DIR/scripts/cm-online $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/lib/connman
    cp -P $PKG_DIR/scripts/connman-setup $INSTALL/usr/lib/connman

  mkdir -p $INSTALL/etc
    ln -sf /var/cache/resolv.conf $INSTALL/etc/resolv.conf

  mkdir -p $INSTALL/etc/connman
    cp ../src/main.conf $INSTALL/etc/connman
    sed -i $INSTALL/etc/connman/main.conf \
        -e "s|^# BackgroundScanning.*|BackgroundScanning = true|g" \
        -e "s|^# FallbackNameservers.*|FallbackNameservers = 8.8.8.8,8.8.4.4|g" \
        -e "s|^# PreferredTechnologies.*|PreferredTechnologies = ethernet,wifi,cellular|g" \
        -e "s|^# TetheringTechnologies.*|TetheringTechnologies = wifi|g" \
        -e "s|^# AllowHostnameUpdates.*|AllowHostnameUpdates = false|g" \
        -e "s|^# PersistentTetheringMode.*|PersistentTetheringMode = true|g"

  mkdir -p $INSTALL/usr/config
    cp $PKG_DIR/config/hosts.conf $INSTALL/usr/config

  mkdir -p $INSTALL/usr/share/connman/
    cp $PKG_DIR/config/settings $INSTALL/usr/share/connman/
}

post_install() {
  add_user system x 430 430 "service" "/var/run/connman" "/bin/sh"
  add_group system 430

  enable_service connman.service
}
