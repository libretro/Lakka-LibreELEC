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

PKG_NAME="libinput"
PKG_VERSION="1.6.3"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/libinput/"
PKG_URL="http://www.freedesktop.org/software/libinput/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain systemd libevdev mtdev"
PKG_SECTION="wayland"
PKG_SHORTDESC="libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver."
PKG_LONGDESC="libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--with-sysroot=$SYSROOT_PREFIX \
                           --enable-shared \
                           --disable-static \
                           --disable-documentation \
                           --disable-event-gui \
                           --disable-tests \
                           --disable-libwacom"
