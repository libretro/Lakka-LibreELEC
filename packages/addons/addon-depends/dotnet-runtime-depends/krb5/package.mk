# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="krb5"
PKG_VERSION="1.17-final"
PKG_SHA256="bd170f6aadea5d753cc9a93a3a915a5bde07bd3d294a00651ed647dcf964e867"
PKG_LICENSE="MIT"
PKG_SITE="http://web.mit.edu/kerberos/"
PKG_URL="https://github.com/krb5/krb5/archive/krb5-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The Kerberos network authentication protocol."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_regcomp=yes \
                           ac_cv_printf_positional=yes \
                           krb5_cv_attr_constructor_destructor=yes,yes"

post_unpack() {
  rm -rf $PKG_BUILD/doc
  mv $PKG_BUILD/src/* $PKG_BUILD
}

makeinstall_target() {
  make install DESTDIR=$INSTALL $PKG_MAKEINSTALL_OPTS_TARGET
}
