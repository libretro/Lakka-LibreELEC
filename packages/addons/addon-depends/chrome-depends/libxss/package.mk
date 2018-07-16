# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxss"
PKG_VERSION="1.2.2"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/lib/libXScrnSaver-$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="libXScrnSaver-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain util-macros libXext scrnsaverproto"
PKG_LONGDESC="X11 Screen Saver extension library"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-malloc0returnsnull"
