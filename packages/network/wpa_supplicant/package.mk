################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="wpa_supplicant"
PKG_VERSION="2.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://hostap.epitest.fi/wpa_supplicant/"
PKG_URL="http://hostap.epitest.fi/releases/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS="dbus openssl"
PKG_BUILD_DEPENDS_TARGET="toolchain dbus libnl openssl"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="wpa_supplicant: An IEEE 802.11i supplicant implementation"
PKG_LONGDESC="The wpa_supplicant is a free software implementation of an IEEE 802.11i supplicant. In addition to being a full-featured WPA2 supplicant, it also has support for WPA and older wireless LAN security protocols."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="-C wpa_supplicant V=1 LIBDIR=/usr/lib BINDIR=/usr/bin"
PKG_MAKEINSTALL_OPTS_TARGET="-C wpa_supplicant V=1 LIBDIR=/usr/lib BINDIR=/usr/bin"

configure_target() {
# wpa_supplicant fails to build with LTO
  strip_lto

  LDFLAGS="$LDFLAGS -lpthread"

  cp $PKG_DIR/config/makefile.config wpa_supplicant/.config

# echo "CONFIG_TLS=gnutls" >> .config
# echo "CONFIG_GNUTLS_EXTRA=y" >> .config
}

post_makeinstall_target() {
  rm -r $INSTALL/usr/bin/wpa_cli

mkdir -p $INSTALL/etc/dbus-1/system.d
  cp wpa_supplicant/dbus/dbus-wpa_supplicant.conf $INSTALL/etc/dbus-1/system.d

mkdir -p $INSTALL/usr/share/dbus-1/system-services
  cp wpa_supplicant/dbus/fi.w1.wpa_supplicant1.service $INSTALL/usr/share/dbus-1/system-services
  cp wpa_supplicant/dbus/fi.epitest.hostap.WPASupplicant.service $INSTALL/usr/share/dbus-1/system-services
}
