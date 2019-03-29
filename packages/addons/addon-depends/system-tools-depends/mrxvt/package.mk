# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mrxvt"
PKG_VERSION="0.5.4"
PKG_SHA256="f403ad5a908fcd38a55ed0a7e1b85584cb77be8781199653a39b8af1a9ad10d7"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://materm.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/materm/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11"
PKG_LONGDESC="A lightweight and powerful multi-tabbed X terminal emulator based on the popular rxvt and aterm."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_setpgrp_void=no \
            --enable-minimal \
            --disable-frills \
            --enable-keepscrolling \
            --disable-selectionscrolling \
            --enable-mousewheel \
            --disable-mouseslipwheel \
            --enable-rxvt-scroll \
            --disable-half-shadow \
            --enable-lastlog \
            --enable-sessionmgr \
            --enable-linespace \
            --enable-24bits \
            --enable-256colors \
            --enable-cursor-blink \
            --enable-pointer-blank \
            --disable-text-shadow \
            --disable-menubar \
            --disable-transparency \
            --disable-tinting \
            --disable-xrender \
            --disable-xpm \
            --disable-jpeg \
            --disable-png \
            --disable-xft \
            --enable-ttygid \
            --enable-backspace-key \
            --enable-delete-key \
            --disable-resources \
            --disable-swapscreen \
            --disable-use-fifo \
            --disable-greek \
            --disable-xim \
            --disable-utempter\
            --with-term=xterm"

makeinstall_target() {
  : # nop
}
