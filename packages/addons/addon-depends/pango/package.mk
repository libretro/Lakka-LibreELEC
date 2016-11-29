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

PKG_NAME="pango"
PKG_VERSION="1.40.3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.pango.org/"
PKG_URL="http://ftp.gnome.org/pub/gnome/sources/pango/1.40/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib cairo freetype fontconfig libX11 libXft harfbuzz"
PKG_SECTION="x11/toolkits"
PKG_SHORTDESC="pango: Library for layout and rendering of internationalized text"
PKG_LONGDESC="The goal of the Pango project is to provide an open-source framework for the layout and rendering of internationalized text. Pango is an offshoot of the GTK+ and GNOME projects, and the initial focus is operation in those environments, however there is nothing fundamentally GTK+ or GNOME specific about Pango. Pango uses Unicode for all of its encoding, and will eventually support output in all the worlds major languages."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-doc-cross-references \
                           --disable-gtk-doc \
                           --disable-man \
                           --enable-debug=no \
                           --with-xft"
