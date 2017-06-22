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

PKG_NAME="xmlstarlet"
PKG_VERSION="1.6.1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://xmlstar.sourceforge.net"
PKG_URL="http://netcologne.dl.sourceforge.net/project/xmlstar/$PKG_NAME/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="toolchain libxml2:host libxslt:host"
PKG_DEPENDS_TARGET="toolchain libxml2 libxslt"
PKG_SECTION="tools"
PKG_SHORTDESC="XMLStarlet is a command-line XML utility which allows the modification and validation of XML documents"
PKG_LONGDESC="XMLStarlet is a command line XML toolkit which can be used to transform,query, validate, and edit XML documents and files using  simple set of shellcommands in similar way it is done for plain text files  using grep/sed/awk/tr/diff/patch."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="  ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes \
                           --enable-static-libs \
                           LIBXML_CONFIG=$TOOLCHAIN/bin/xml2-config \
                           LIBXSLT_CONFIG=$TOOLCHAIN/bin/xslt-config \
                           --with-libxml-include-prefix=$TOOLCHAIN/include/libxml2 \
                           --with-libxml-libs-prefix=$TOOLCHAIN/lib \
                           --with-libxslt-include-prefix=$TOOLCHAIN/include \
                           --with-libxslt-libs-prefix=$TOOLCHAIN/lib"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes \
                           --enable-static-libs \
                           LIBXML_CONFIG=$SYSROOT_PREFIX/usr/bin/xml2-config \
                           LIBXSLT_CONFIG=$SYSROOT_PREFIX/usr/bin/xslt-config \
                           --with-libxml-include-prefix=$SYSROOT_PREFIX/usr/include/libxml2 \
                           --with-libxml-libs-prefix=$SYSROOT_PREFIX/usr/lib \
                           --with-libxslt-include-prefix=$SYSROOT_PREFIX/usr/include \
                           --with-libxslt-libs-prefix=$SYSROOT_PREFIX/usr/lib"

post_makeinstall_host() {
  ln -sf xml $TOOLCHAIN/bin/xmlstarlet
}

post_makeinstall_target() {
  ln -sf xml $INSTALL/usr/bin/xmlstarlet
}
