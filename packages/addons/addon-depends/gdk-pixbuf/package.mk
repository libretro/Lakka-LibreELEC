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

PKG_NAME="gdk-pixbuf"
PKG_VERSION="2.34.0"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.gtk.org/"
PKG_URL="http://ftp.acc.umu.se/pub/gnome/sources/gdk-pixbuf/2.34/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib libjpeg-turbo libpng jasper tiff"
PKG_SECTION="x11/toolkits"
PKG_SHORTDESC="gdk-pixbuf: a GNOME library for image loading and manipulation."
PKG_LONGDESC="gdk-pixbuf (GdkPixbuf) is a GNOME library for image loading and manipulation. The GdkPixbuf documentation contains both the programmer's guide and the API reference."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="gio_can_sniff=yes \
                           --disable-gtk-doc \
                           --disable-gtk-doc-html \
                           --disable-gtk-doc-pdf \
                           --disable-man \
                           --with-libpng \
                           --with-libjpeg \
                           --with-libtiff \
                           --with-libjasper"
