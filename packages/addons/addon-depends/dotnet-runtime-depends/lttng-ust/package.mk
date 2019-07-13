# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lttng-ust"
PKG_VERSION="2.10.4"
PKG_SHA256="9df458fbfeac5a380672751decbd9b57356075acbfe106cb8820e803a94a0d96"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="https://lttng.org/"
PKG_URL="https://github.com/lttng/lttng-ust/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain userspace-rcu"
PKG_LONGDESC="LTTng is an open source tracing framework for Linux"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-man-pages"

makeinstall_target() {
  make install DESTDIR=$INSTALL $PKG_MAKEINSTALL_OPTS_TARGET
}
