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

PKG_NAME="TwistedConch"
PKG_VERSION="11.0.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://twistedmatrix.com/"
PKG_URL="http://twistedmatrix.com/Releases/Conch/11.0/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host TwistedCore pyasn1 pycrypto"
PKG_PRIORITY="optional"
PKG_SECTION="python/web"
PKG_SHORTDESC="TwistedConch: an SSHv2 implementation written in Python"
PKG_LONGDESC="TwistedConch is an SSHv2 implementation written in Python. SSH is a protocol designed to allow remote access to shells and commands, but it is generic enough to allow everything from TCP forwarding to generic filesystem access. Since conch is written in Python, it interfaces well with other Python projects, such as Imagination. Conch also includes a implementations of the telnet and vt102 protocols, as well as support for rudimentary line editing behaviors. A new implementation of Twisted's Manhole application is also included, featuring server-side input history and interactive syntax coloring."

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

# install to toolchain because its needed for other twisted modules
  python setup.py install --prefix $ROOT/$TOOLCHAIN
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  rm -rf $INSTALL/usr/lib/python*/site-packages/twisted/conch/test
}
