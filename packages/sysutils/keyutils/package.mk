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

PKG_NAME="keyutils"
PKG_VERSION="1.5.9"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://people.redhat.com/~dhowells/keyutils/"
PKG_URL="http://people.redhat.com/~dhowells/keyutils/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="keyutils: Linux Key Management Utilities"
PKG_LONGDESC="Keyutils is a set of utilities for managing the key retention facility in the kernel."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_MAKE_OPTS_TARGET="NO_ARLIB=0 NO_SOLIB=1 LIBDIR=/lib USRLIBDIR=/usr/lib"
PKG_MAKEINSTALL_OPTS_TARGET="$PKG_MAKE_OPTS_TARGET"

post_makeinstall_target() {
	rm -rf $INSTALL/usr
	rmdir $INSTALL/etc/request-key.d
	ln -sf /storage/.config/request-key.d $INSTALL/etc/request-key.d
}

