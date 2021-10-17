# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libICE"
PKG_VERSION="1.0.10"
PKG_SHA256="6f86dce12cf4bcaf5c37dddd8b1b64ed2ddf1ef7b218f22b9942595fb747c348"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros xtrans"
PKG_LONGDESC="X Inter-Client Exchange (ICE) protocol library."

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --enable-shared \
                           --disable-ipv6 \
                           --without-xmlto"
