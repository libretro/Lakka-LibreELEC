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

PKG_NAME="dbus-glib"
PKG_VERSION="0.100.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://freedesktop.org/wiki/Software/dbus"
PKG_URL="http://dbus.freedesktop.org/releases/dbus-glib/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="glib:host dbus:host"
PKG_DEPENDS_TARGET="toolchain dbus glib expat dbus-glib:host"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="dbus-glib: A message bus system"
PKG_LONGDESC="D-BUS is a message bus, used for sending messages between applications. Conceptually, it fits somewhere in between raw sockets and CORBA in terms of complexity."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_have_abstract_sockets=yes \
                           ac_cv_func_posix_getpwnam_r=yes \
                           have_abstract_sockets=yes \
                           --enable-static \
                           --disable-shared \
                           --disable-tests \
                           --disable-bash-completion \
                           --enable-asserts=no \
                           --with-introspect-xml=$PKG_BUILD/.$HOST_NAME/introspect.xml \
                           --with-dbus-binding-tool=$ROOT/$TOOLCHAIN/bin/dbus-binding-tool"

PKG_CONFIGURE_OPTS_HOST="--disable-tests \
                         --disable-bash-completion \
                         --enable-asserts=yes"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/dbus-binding-tool
}
