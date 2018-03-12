################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="heimdal"
PKG_VERSION="7.5.0"
PKG_SHA256="ad67fef994dc2268fb0b1a8164b39330d184f425057867485a178e9785a7f35a"
PKG_ARCH="any"
PKG_LICENSE="BSD-3c"
PKG_SITE="http://www.h5l.org/"
PKG_URL="https://github.com/heimdal/heimdal/archive/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="$PKG_NAME-$PKG_NAME-$PKG_VERSION"
PKG_DEPENDS_HOST="toolchain e2fsprogs:host Python2:host"
PKG_SECTION="devel"
PKG_SHORTDESC="heimdal: Kerberos 5, PKIX, CMS, GSS-API, SPNEGO, NTLM, Digest-MD5 and, SASL implementation."
PKG_LONGDESC="Heimdal is an implementation of Kerberos 5 (and some more stuff) largely written in Sweden (which was important when we started writing it, less so now). It is freely available under a three clause BSD style license. "
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-parallel"

PKG_CONFIGURE_OPTS_HOST="--enable-static --disable-shared \
                         --without-openldap \
                         --without-capng \
                         --without-sqlite3 \
                         --without-libintl \
                         --without-openssl \
                         --without-berkeley-db \
                         --without-readline \
                         --without-libedit \
                         --without-hesiod \
                         --without-x \
                         --disable-otp \
                         --with-db-type-preference= \
                         --disable-heimdal-documentation"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp -PR lib/asn1/asn1_compile $TOOLCHAIN/bin
}
