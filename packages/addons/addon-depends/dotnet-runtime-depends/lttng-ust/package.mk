# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lttng-ust"
PKG_VERSION="2.10.2"
PKG_SHA256="015452be6f94e4468315d0478cd5a4d01d9e52672bcea122b4ff7426198d5803"
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
