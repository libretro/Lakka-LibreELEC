# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXmu"
PKG_VERSION="1.1.2"
PKG_SHA256="756edc7c383254eef8b4e1b733c3bf1dc061b523c9f9833ac7058378b8349d0b"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libXext libX11 libXt"
PKG_LONGDESC="LibXmu provides a set of miscellaneous utility convenience functions for X libraries to use."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --with-gnu-ld --without-xmlto"
