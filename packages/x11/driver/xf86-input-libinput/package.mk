# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="xf86-input-libinput"
PKG_VERSION="0.26.0"
PKG_SHA256="abca558fc2226f295691f1cf3412d4c0edeaa439f677ca25b5c9fab310d2387b"
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
