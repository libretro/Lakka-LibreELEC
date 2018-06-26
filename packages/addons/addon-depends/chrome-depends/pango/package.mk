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

PKG_NAME="pango"
PKG_VERSION="1.42.1"
PKG_SHA256="915a6756b298578ff27c7a6393f8c2e62e6e382f9411f2504d7af1a13c7bce32"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.pango.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/pango/${PKG_VERSION:0:4}/pango-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain cairo freetype fontconfig fribidi glib harfbuzz libX11 libXft"
PKG_LONGDESC="The Pango library for layout and rendering of internationalized text."
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Denable_docs=false \
                       -Dgir=false"
