################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="xbindkeys"
PKG_VERSION="1.8.6"
PKG_URL="https://www.nongnu.org/xbindkeys/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_SHORTDESC="xbindkeys is a program that allows you to launch shell commands with your keyboard or your mouse under X Window. It links commands to keys or mouse buttons, using a configuration file. It's independant of the window manager and can capture all keyboard keys (ex: Power, Wake...)."
PKG_ARCH="any"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-guile"
