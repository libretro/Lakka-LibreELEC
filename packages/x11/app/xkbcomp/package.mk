# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xkbcomp"
PKG_VERSION="1.4.1"
PKG_SHA256="748dc4cf58ac95684106bd9cf163ac6ab7de9a236faec02a6f4d4006d63a5736"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/app/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libX11 libxkbfile"
PKG_LONGDESC="The xkbcomp keymap compiler converts a description of an XKB keymap into one of several output formats."

PKG_CONFIGURE_OPTS_TARGET="--with-xkb-config-root=$XORG_PATH_XKB"
