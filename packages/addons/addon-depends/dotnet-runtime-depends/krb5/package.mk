# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="krb5"
PKG_VERSION="1.16.1-final"
PKG_SHA256="d46a676bd6cfe58b8684ffd881bc7ed2c9c90cb43ccfa45a9500530e84aa262b"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://web.mit.edu/kerberos/"
PKG_URL="https://github.com/krb5/krb5/archive/krb5-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="krb5-krb5-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The Kerberos network authentication protocol"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_regcomp=yes \
                           ac_cv_printf_positional=yes \
                           krb5_cv_attr_constructor_destructor=yes,yes"

post_unpack() {
  rm -rf $PKG_BUILD/doc
  mv $PKG_BUILD/src/* $PKG_BUILD
}
