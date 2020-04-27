# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lttng-ust"
PKG_VERSION="2.12.0"
PKG_SHA256="ae9a7c7a9730deabacc6c690dcf1ba1c988f7f474326ba33d30b3f339d27a059"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="https://lttng.org/"
PKG_URL="https://github.com/lttng/lttng-ust/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain userspace-rcu"
PKG_LONGDESC="LTTng is an open source tracing framework for Linux"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-man-pages --disable-numa"

makeinstall_target() {
  make install DESTDIR=$INSTALL $PKG_MAKEINSTALL_OPTS_TARGET
}
