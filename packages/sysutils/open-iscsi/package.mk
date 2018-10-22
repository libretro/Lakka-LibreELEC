# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2012 Yann Cézard (eesprit@free.fr)
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="open-iscsi"
PKG_VERSION="bf39941"
PKG_SHA256="92b9f0a27a9a373b14eab7b12f1bfff5d4857695a688dc4434df8e7623354588"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/mikechristie/open-iscsi"
PKG_URL="https://github.com/mikechristie/open-iscsi/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_INIT="toolchain util-linux"
PKG_LONGDESC="The open-iscsi package allows you to mount iSCSI targets."
PKG_TOOLCHAIN="configure"

PKG_MAKE_OPTS_INIT="user"

pre_configure_init() {
  export OPTFLAGS="$CFLAGS $LDFLAGS"
}

configure_init() {
  cd utils/open-isns
    ./configure --host=$TARGET_NAME \
                --build=$HOST_NAME \
                --with-security=no
  cd ../..
}

makeinstall_init() {
  mkdir -p $INSTALL/usr/sbin
    cp -P $PKG_BUILD/usr/iscsistart $INSTALL/usr/sbin
}
