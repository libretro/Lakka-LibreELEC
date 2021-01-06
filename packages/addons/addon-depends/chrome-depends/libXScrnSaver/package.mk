# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXScrnSaver"
PKG_VERSION="1.2.3"
PKG_SHA256="f917075a1b7b5a38d67a8b0238eaab14acd2557679835b154cf2bca576e89bf8"
PKG_LICENSE="GPL"
PKG_SITE="http://xorg.freedesktop.org/"
PKG_URL="https://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain scrnsaverproto"
PKG_LONGDESC="X11 Screen Saver extension client library."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                           --enable-shared \
                           --enable-malloc0returnsnull"
