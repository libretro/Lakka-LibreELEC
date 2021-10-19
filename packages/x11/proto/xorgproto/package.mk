# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xorgproto"
PKG_VERSION="2021.5"
PKG_SHA256="aa2f663b8dbd632960b24f7477aa07d901210057f6ab1a1db5158732569ca015"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/proto/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_LONGDESC="combined X.Org X11 Protocol headers"
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Dlegacy=false"
