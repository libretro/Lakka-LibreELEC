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

PKG_NAME="avahi"
PKG_VERSION="0.6.31"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://avahi.org/"
PKG_URL="http://www.avahi.org/download/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain expat libdaemon dbus connman"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="avahi: A Zeroconf mDNS/DNS-SD responder"
PKG_LONGDESC="Avahi is a framework for Multicast DNS Service Discovery (mDNS/DNS-SD a.k.a. Zeroconf) on Linux. It allows programs to publish and discover services running on a local network with no specific configuration. For example, you can plug into a network and instantly find printers to print to, files to look at, and people to talk to."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

MAKEFLAGS="-j1"

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
                           --disable-pygtk \
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
                           --disable-compat-libdns_sd \
                           --disable-compat-howl \
                           --with-xml=expat \
                           --with-avahi-user=avahi \
                           --with-avahi-group=avahi \
                           --disable-nls"

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

  mkdir -p $INSTALL/usr/share/services
    cp -P $PKG_DIR/default.d/*.conf $INSTALL/usr/share/services

}

post_install() {
  add_user avahi x 495 495 "avahi-daemon" "/var/run/avahi-daemon" "/bin/sh"
  add_group avahi 495

  enable_service avahi-defaults.service
  enable_service avahi-daemon.service
}
