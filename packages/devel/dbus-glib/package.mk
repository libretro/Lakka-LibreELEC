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

PKG_NAME="dbus-glib"
PKG_VERSION="0.108"
PKG_SHA256="9f340c7e2352e9cdf113893ca77ca9075d9f8d5e81476bf2bf361099383c602c"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://freedesktop.org/wiki/Software/dbus"
PKG_URL="https://dbus.freedesktop.org/releases/dbus-glib/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain dbus glib expat"
PKG_SECTION="devel"
PKG_SHORTDESC="dbus-glib: A message bus system"
PKG_LONGDESC="D-BUS is a message bus, used for sending messages between applications. Conceptually, it fits somewhere in between raw sockets and CORBA in terms of complexity."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_have_abstract_sockets=yes \
                           ac_cv_func_posix_getpwnam_r=yes \
                           have_abstract_sockets=yes \
                           --enable-static \
                           --disable-shared \
                           --disable-tests \
                           --disable-bash-completion \
                           --enable-asserts=no"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/dbus-binding-tool
}
