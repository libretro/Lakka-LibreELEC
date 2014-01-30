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

PKG_NAME="TwistedWords"
PKG_VERSION="11.0.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://twistedmatrix.com/"
PKG_URL="http://twistedmatrix.com/Releases/Words/11.0/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host TwistedCore"
PKG_PRIORITY="optional"
PKG_SECTION="python/web"
PKG_SHORTDESC="TwistedWords: An event-based networking framework for Internet applications"
PKG_LONGDESC="Twisted is an event-based framework for Internet applications. It includes a Web server, an SMTP/POP3 server, a telnet server, an SSH server, an IRC server, a DNS server, a generic client/server pair for remote object access (Perspective Broker), and APIs for creating new protocols. It supports integration with GTK+, GTK+ 2, Qt, Tkinter, wxPython, Mac OS X (PyObjC) and Win32 event loops. It also supports TCP, SSL and TLS, UDP, Unix sockets, multicast, and serial ports. Supported protocols include HTTP, FTP, SMTP, POP3, IMAP, TOC, OSCAR (AIM and ICQ), SSH, DNS, IRC, NNTP, Jabber, SOCKSv4, Telnet, SIP (for VoIP), and XML-RPC and SOAP using external packages. Most protocols are supported as both servers and clients."

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
  rm -rf $INSTALL/usr/lib/python*/site-packages/twisted/words/test
}
