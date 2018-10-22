# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="avahi"
PKG_VERSION="0.7"
PKG_SHA256="fd45480cef0559b3eab965ea3ad4fe2d7a8f27db32c851a032ee0b487c378329"
PKG_LICENSE="GPL"
PKG_SITE="http://avahi.org/"
PKG_URL="https://github.com/lathiat/avahi/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain expat libdaemon dbus connman"
PKG_LONGDESC="Service Discovery for Linux using mDNS/DNS-SD, compatible with Bonjour."
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="py_cv_mod_gtk_=yes \
                           py_cv_mod_dbus_=yes \
                           ac_cv_func_chroot=no \
                           --with-distro=none \
                           --disable-glib \
                           --disable-gobject \
                           --disable-qt3 \
                           --disable-qt4 \
                           --disable-gtk \
                           --disable-gtk3 \
                           --enable-dbus \
                           --disable-dbm \
                           --disable-gdbm \
                           --enable-libdaemon \
                           --disable-python \
                           --disable-python-dbus \
                           --disable-mono \
                           --disable-monodoc \
                           --disable-autoipd \
                           --disable-doxygen-doc \
                           --disable-doxygen-dot \
                           --disable-doxygen-man \
                           --disable-doxygen-rtf \
                           --disable-doxygen-xml \
                           --disable-doxygen-chm \
                           --disable-doxygen-chi \
                           --disable-doxygen-html \
                           --disable-doxygen-ps \
                           --disable-doxygen-pdf \
                           --disable-core-docs \
                           --disable-manpages \
                           --disable-xmltoman \
                           --disable-tests \
                           --enable-compat-libdns_sd \
                           --disable-compat-howl \
                           --with-xml=expat \
                           --with-avahi-user=avahi \
                           --with-avahi-group=avahi \
                           --disable-nls"

pre_configure_target() {
  NOCONFIGURE=1 ./autogen.sh
}

post_makeinstall_target() {
# for some reason avai can fail to start see: http://forums.gentoo.org/viewtopic-p-7322172.html#7322172
  sed -e "s,^.*disallow-other-stacks=.*$,disallow-other-stacks=yes,g" -i $INSTALL/etc/avahi/avahi-daemon.conf
# disable wide-area
  sed -e "s,^.*enable-wide-area=.*$,enable-wide-area=no,g" -i $INSTALL/etc/avahi/avahi-daemon.conf
# publish-hinfo
  sed -e "s,^.*publish-hinfo=.*$,publish-hinfo=no,g" -i $INSTALL/etc/avahi/avahi-daemon.conf
# publish-workstation
  sed -e "s,^.*publish-workstation=.*$,publish-workstation=no,g" -i $INSTALL/etc/avahi/avahi-daemon.conf
# browse domains?
  sed -e "s,^.*browse-domains=.*$,# browse-domains=,g" -i $INSTALL/etc/avahi/avahi-daemon.conf

  rm -rf $INSTALL/etc/avahi/avahi-dnsconfd.action
  rm -rf $INSTALL/etc/avahi/services/ssh.service
  if [ ! $SFTP_SERVER = "yes" ]; then
    rm -rf $INSTALL/etc/avahi/services/sftp-ssh.service
  fi
  rm -rf $INSTALL/usr/lib/systemd
  rm -f $INSTALL/usr/share/dbus-1/system-services/org.freedesktop.Avahi.service
  rm -f $INSTALL/usr/sbin/avahi-dnsconfd
  rm -f $INSTALL/usr/bin/avahi-bookmarks
  rm -f $INSTALL/usr/bin/avahi-publish*
  rm -f $INSTALL/usr/bin/avahi-resolve*
  rm -f $INSTALL/usr/lib/libdns_sd*

  mkdir -p $INSTALL/usr/share/services
    cp -P $PKG_DIR/default.d/*.conf $INSTALL/usr/share/services
}

post_install() {
  add_user avahi x 495 495 "avahi-daemon" "/var/run/avahi-daemon" "/bin/sh"
  add_group avahi 495

  enable_service avahi-defaults.service
  enable_service avahi-daemon.service
}
