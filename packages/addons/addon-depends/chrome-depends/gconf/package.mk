################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="gconf"
PKG_VERSION="3.2.6"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://projects-old.gnome.org/gconf/"
PKG_URL="https://download.gnome.org/sources/GConf/3.2/GConf-$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="GConf-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain zlib glib dbus-glib glfw"
PKG_LONGDESC="GConf is a system for storing application preferences."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --disable-gtk-doc \
                           --disable-orbit"
