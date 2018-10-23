# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="wpa_supplicant"
PKG_VERSION="2.6"
PKG_SHA256="b4936d34c4e6cdd44954beba74296d964bc2c9668ecaa5255e499636fe2b1450"
PKG_LICENSE="GPL"
PKG_SITE="https://w1.fi/wpa_supplicant/"
PKG_URL="https://w1.fi/releases/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain dbus libnl openssl"
PKG_LONGDESC="A free software implementation of an IEEE 802.11i supplicant."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto-parallel"

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
