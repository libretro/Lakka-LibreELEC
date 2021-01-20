# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="encodings"
PKG_VERSION="1.0.5"
PKG_SHA256="bd96e16143a044b19e87f217cf6a3763a70c561d1076aad6f6d862ec41774a31"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/font/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros font-util:host"
PKG_LONGDESC="X font encoding meta files."

PKG_CONFIGURE_OPTS_TARGET="--enable-gzip-small-encodings \
                           --enable-gzip-large-encodings \
                           --with-fontrootdir=/usr/share/fonts"
