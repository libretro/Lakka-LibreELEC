# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lttng-ust"
PKG_VERSION="2.10.1"
PKG_SHA256="8503bb36c95fc3473eb6323b84645e9d95ff52758ad199d2fe7ca80277f81b95"
PKG_ARCH="any"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="https://lttng.org/"
PKG_URL="https://github.com/lttng/lttng-ust/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain userspace-rcu"
PKG_LONGDESC="LTTng is an open source tracing framework for Linux"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-man-pages"
