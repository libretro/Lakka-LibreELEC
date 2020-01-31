# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xorgproto"
PKG_VERSION="2019.2"
PKG_SHA256="46ecd0156c561d41e8aa87ce79340910cdf38373b759e737fcbba5df508e7b8e"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/proto/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_LONGDESC="combined X.Org X11 Protocol headers"
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Dlegacy=false"
