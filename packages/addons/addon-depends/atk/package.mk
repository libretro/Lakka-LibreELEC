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

PKG_NAME="atk"
PKG_VERSION="2.27.1"
PKG_SHA256="673a953987b301ab1e24e7d11677b6e7ba3226411a168449ba946765b6d44297"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://library.gnome.org/devel/atk/"
PKG_URL="http://ftp.gnome.org/pub/gnome/sources/$PKG_NAME/2.27/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib glib:host"
PKG_SECTION="accessibility"
PKG_SHORTDESC="ATK - Accessibility Toolkit"
PKG_LONGDESC="ATK provides the set of accessibility interfaces that are implemented by other toolkits and applications. Using the ATK interfaces, accessibility tools have full access to view and control running applications."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           --disable-rebuilds --enable-introspection=no"
