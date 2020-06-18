# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="userspace-rcu"
PKG_VERSION="0.12.0"
PKG_SHA256="6b0cdee07a651c56daea8d03285f379afab898ebc83c785a23927320e45a3012"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="http://liburcu.org"
PKG_URL="https://github.com/urcu/userspace-rcu/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="userspace read-copy-update library"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static"
