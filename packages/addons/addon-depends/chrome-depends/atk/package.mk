################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="atk"
PKG_VERSION="2.29.1"
PKG_SHA256="1aa7707c6297c1797fe4d79a22a57ede4d5586b0f7a3b30e886d7ca9d75f20da"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://library.gnome.org/devel/atk/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/atk/${PKG_VERSION:0:4}/atk-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib glib:host"
PKG_LONGDESC="ATK provides the set of accessibility interfaces that are implemented by other toolkits and applications."
PKG_BUILD_FLAGS="+pic"

PKG_MESON_OPTS_TARGET="-Ddocs=false \
                       -Dintrospection=false"
