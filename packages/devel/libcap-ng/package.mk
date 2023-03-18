# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libcap-ng"
PKG_VERSION="0.8.3"
PKG_SHA256="e542e9139961f0915ab5878427890cdc7762949fbe216bd0cb4ceedb309bb854"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="https://github.com/stevegrubb/libcap-ng"
PKG_URL="https://github.com/stevegrubb/libcap-ng/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libcap-ng is a library for Linux that makes using posix capabilities easy."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --with-python=no --with-python3=no"
