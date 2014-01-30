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

PKG_NAME="wokkel"
PKG_VERSION="0.6.3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="free"
PKG_SITE="http://wokkel.ik.nu/"
PKG_URL="http://wokkel.ik.nu/releases/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host TwistedWords"
PKG_PRIORITY="optional"
PKG_SECTION="python/web"
PKG_SHORTDESC="wokkel: Wokkel is a Python module for experimenting with future enhancements to TwistedWords"
PKG_LONGDESC="Wokkel is collection of enhancements on top of the Twisted networking framework, written in Python. It mostly provides a testing ground for enhancements to the Jabber/XMPP protocol implementation as found in Twisted Words, that are meant to eventually move there."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
}

make_target() {
  python setup.py build --cross-compile
}

makeinstall_target() {
  python setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/wokkel/test
}
