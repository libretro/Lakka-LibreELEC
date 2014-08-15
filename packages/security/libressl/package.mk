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

PKG_NAME="libressl"
PKG_VERSION="2.0.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://www.libressl.org/"
PKG_URL="http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="security"
PKG_SHORTDESC="libressl: a FREE version of the SSL/TLS protocol forked from OpenSSL"
PKG_LONGDESC="LibreSSL is a FREE version of the SSL/TLS protocol forked from OpenSSL"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

post_makeinstall_target() {
# ca-certification: provides a tool to download and create ca-bundle.crt
# download url: http://curl.haxx.se
# create new cert: perl ./mk-ca-bundle.pl
  mkdir -p $INSTALL/$SSL_CERTIFICATES
    cp $PKG_DIR/cert/ca-bundle.crt $INSTALL/$SSL_CERTIFICATES/cacert.pem
}
