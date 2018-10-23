# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXScrnSaver"
PKG_VERSION="1.2.2"
PKG_SHA256="8ff1efa7341c7f34bcf9b17c89648d6325ddaae22e3904e091794e0b4426ce1d"
PKG_LICENSE="GPL"
PKG_SITE="http://xorg.freedesktop.org/"
PKG_URL="https://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain scrnsaverproto"
PKG_LONGDESC="X11 Screen Saver extension client library."

PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                           --enable-shared \
                           --enable-malloc0returnsnull"

makeinstall_target() {
  :
}
