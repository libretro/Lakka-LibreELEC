# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-input-libinput"
PKG_VERSION="0.28.2"
PKG_SHA256="b8b346962c6b62b8069928c29c0db83b6f544863bf2fc6830f324de841de2820"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/libinput/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libinput"
PKG_LONGDESC="This is an X driver based on libinput."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-xorg-module-dir=$XORG_PATH_MODULES"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/share/X11/xorg.conf.d
    cp $PKG_BUILD/conf/*-libinput.conf $INSTALL/usr/share/X11/xorg.conf.d
}
