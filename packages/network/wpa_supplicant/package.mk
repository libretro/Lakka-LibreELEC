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

PKG_NAME="wpa_supplicant"
PKG_VERSION="2.6"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://hostap.epitest.fi/wpa_supplicant/"
PKG_URL="http://hostap.epitest.fi/releases/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain dbus libnl openssl"
PKG_SECTION="network"
PKG_SHORTDESC="wpa_supplicant: An IEEE 802.11i supplicant implementation"
PKG_LONGDESC="The wpa_supplicant is a free software implementation of an IEEE 802.11i supplicant. In addition to being a full-featured WPA2 supplicant, it also has support for WPA and older wireless LAN security protocols."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="-C wpa_supplicant V=1 LIBDIR=/usr/lib BINDIR=/usr/bin"
PKG_MAKEINSTALL_OPTS_TARGET="-C wpa_supplicant V=1 LIBDIR=/usr/lib BINDIR=/usr/bin"

configure_target() {
  LDFLAGS="$LDFLAGS -lpthread -lm"

  cp $PKG_DIR/config/makefile.config wpa_supplicant/.config

# echo "CONFIG_TLS=gnutls" >> .config
# echo "CONFIG_GNUTLS_EXTRA=y" >> .config
}

post_makeinstall_target() {
  rm -r $INSTALL/usr/bin/wpa_cli

mkdir -p $INSTALL/etc/dbus-1/system.d
  cp wpa_supplicant/dbus/dbus-wpa_supplicant.conf $INSTALL/etc/dbus-1/system.d

mkdir -p $INSTALL/usr/lib/systemd/system
  cp wpa_supplicant/systemd/wpa_supplicant.service $INSTALL/usr/lib/systemd/system

mkdir -p $INSTALL/usr/share/dbus-1/system-services
  cp wpa_supplicant/dbus/fi.w1.wpa_supplicant1.service $INSTALL/usr/share/dbus-1/system-services
  cp wpa_supplicant/dbus/fi.epitest.hostap.WPASupplicant.service $INSTALL/usr/share/dbus-1/system-services
}
