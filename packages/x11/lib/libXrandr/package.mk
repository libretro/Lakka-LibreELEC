# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXrandr"
PKG_VERSION="1.5.2"
PKG_SHA256="8aea0ebe403d62330bb741ed595b53741acf45033d3bda1792f1d4cc3daee023"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libX11 libXrender libXext"
PKG_LONGDESC="Xrandr is a simple library designed to interface the X Resize and Rotate Extension."

PKG_CONFIGURE_OPTS_TARGET="--enable-malloc0returnsnull"
