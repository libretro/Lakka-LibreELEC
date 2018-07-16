# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libev"
PKG_VERSION="4.24"
PKG_SHA256="973593d3479abdf657674a55afe5f78624b0e440614e2b8cb3a07f16d4d7f821"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://software.schmorp.de/pkg/libev.html"
PKG_URL="http://dist.schmorp.de/libev/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libev: a full-featured and high-performance event loop"
PKG_LONGDESC="A full-featured and high-performance event loop that is loosely modelled after libevent, but without its limitations and bugs."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"
