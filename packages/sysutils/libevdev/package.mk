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

PKG_NAME="libevdev"
PKG_VERSION="1.5.7"
PKG_SHA256="a1e59e37a2f0d397ffd7e83b73af0e638db83b8dd08902ef0f651a21cc1dd422"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/libevdev/"
PKG_URL="http://www.freedesktop.org/software/libevdev/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="libevdev: a wrapper library for evdev devices."
PKG_LONGDESC="libevdev is a wrapper library for evdev devices. it moves the common tasks when dealing with evdev devices into a library and provides a library interface to the callers, thus avoiding erroneous ioctls, etc."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared --disable-static"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
