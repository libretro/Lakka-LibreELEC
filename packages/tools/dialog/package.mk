################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="dialog"
PKG_VERSION="1.2-20150920"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://invisible-island.net/dialog/"
PKG_URL="ftp://invisible-island.net/dialog/$PKG_NAME-$PKG_VERSION.tgz"
PKG_DEPENDS_TARGET="toolchain netbsd-curses"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="dialog: A utility for creating TTY dialog boxes"
PKG_LONGDESC="Dialog is a utility that allows you to show dialog boxes (containing questions or messages) in TTY (text mode) interfaces from shell scripts. Dialog is initally written by Savio Lam and various branches do exist (e.g. lxdialog which is used for a linux kernel make menuconfig). This is the branch maintained by Thomas Dickey."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
                           --without-dbmalloc \
                           --without-dmalloc \
                           --with-ncurses \
                           --disable-widec \
                           --disable-rc-file \
                           --disable-Xdialog \
                           --disable-form \
                           --disable-mixedform \
                           --disable-tailbox"

