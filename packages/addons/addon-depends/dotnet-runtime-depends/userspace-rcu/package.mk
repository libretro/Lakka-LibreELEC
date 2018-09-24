# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="userspace-rcu"
PKG_VERSION="0.10.1"
PKG_SHA256="4ddbca9927b459b7a295dec612cf43df5886d398161d50c59d0097995e368a3b"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="http://liburcu.org"
PKG_URL="https://github.com/urcu/userspace-rcu/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="userspace read-copy-update library"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static"
