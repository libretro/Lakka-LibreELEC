# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXinerama"
PKG_VERSION="1.1.4"
PKG_SHA256="0008dbd7ecf717e1e507eed1856ab0d9cf946d03201b85d5dcf61489bb02d720"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libXext"
PKG_LONGDESC="libXinerama is the Xinerama library."

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --enable-malloc0returnsnull"
