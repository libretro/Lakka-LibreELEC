# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxkbfile"
PKG_VERSION="1.0.9"
PKG_SHA256="51817e0530961975d9513b773960b4edd275f7d5c72293d5a151ed4f42aeb16a"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libX11"
PKG_LONGDESC="Libxkbfile provides an interface to read and manipulate description files for XKB, the X11 keyboard configuration extension."

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"
