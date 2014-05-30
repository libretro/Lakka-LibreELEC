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

PKG_NAME="gnutls"
PKG_VERSION="3.2.15"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.gnutls.org/"
PKG_URL="ftp://ftp.gnutls.org/gcrypt/gnutls/v3.2/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib nettle"
PKG_PRIORITY="optional"
PKG_SECTION="security"
PKG_SHORTDESC="gnutls: Development Library for TLS applications"
PKG_LONGDESC="GnuTLS is a project that aims to develop a library which provides a secure layer, over a reliable transport layer. Currently the GnuTLS library implements the proposed standards by the IETF's TLS working group. Quoting from RFC2246 - the TLS 1.0 protocol specification: The TLS protocol provides communications privacy over the Internet. The protocol allows client/server applications to communicate in a way that is designed to prevent eavesdropping, tampering, or message forgery."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-hardware-acceleration \
                           --disable-openssl-compatibility \
                           --disable-cxx \
                           --without-p11-kit \
                           --enable-local-libopts \
                           --with-included-libtasn1 \
                           --with-sysroot=$SYSROOT_PREFIX/usr \
                           --with-libz-prefix=$SYSROOT_PREFIX/usr \
                           --with-librt-prefix=$SYSROOT_PREFIX/usr \
                           --with-libpthread-prefix=$SYSROOT_PREFIX/usr \
                           --without-libiconv-prefix \
                           --without-libintl-prefix \
                           --disable-libdane \
                           --disable-doc \
                           --disable-nls \
                           --disable-guile \
                           --disable-valgrind-tests \
                           --without-lzo \
                           --with-gnu-ld"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
