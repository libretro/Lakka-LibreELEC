################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="mrxvt"
PKG_VERSION="0.5.4"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://materm.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/materm/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11"
PKG_SECTION="tools"
PKG_SHORTDESC="mrxvt: Lightweight Xterm replacement"
PKG_LONGDESC="Mrxvt (previously named as materm) is a lightweight and powerful multi-tabbed X terminal emulator based on the popular rxvt and aterm. It implements many useful features seen in some modern X terminal emulators, like gnome-terminal and konsole, but keep to be lightweight and independent from the GNOME and KDE desktop environment."
PKG_AUTORECONF="yes"


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
