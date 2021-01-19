# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libffi"
PKG_VERSION="3.3"
PKG_SHA256="72fba7922703ddfa7a028d513ac15a85c8d54c8d67f55fa5a4802885dc652056"
PKG_LICENSE="GPL"
PKG_SITE="http://sourceware.org/${PKG_NAME}/"
PKG_URL="ftp://sourceware.org/pub/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host autoconf:host automake:host libtool:host pkg-config:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Foreign Function Interface Library."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-debug \
                           --enable-static --disable-shared \
                           --with-pic \
                           --enable-structs \
                           --enable-raw-api \
                           --disable-purify-safety \
                           --with-gnu-ld"
