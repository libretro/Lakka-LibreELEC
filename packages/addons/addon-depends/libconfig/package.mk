# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libconfig"
PKG_VERSION="1.5"
PKG_SHA256="cae5c02361d8a9b2bb26946c64f089d2e5e599972f386203fbc48975c0d885c8"
PKG_LICENSE="LGPL"
PKG_SITE="http://hyperrealm.com/libconfig/libconfig.html"
PKG_URL="https://github.com/hyperrealm/libconfig/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A C/C++ configuration file library."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-examples \
                           --with-sysroot=$SYSROOT_PREFIX"
