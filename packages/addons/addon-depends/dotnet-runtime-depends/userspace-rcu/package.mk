# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="userspace-rcu"
PKG_VERSION="0.11.1"
PKG_SHA256="a0ed8995edfbeac5f5eb2f152a8f3654040ecfc99a746bfe3da3bccf435b7d5d"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="http://liburcu.org"
PKG_URL="https://github.com/urcu/userspace-rcu/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="userspace read-copy-update library"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static"
