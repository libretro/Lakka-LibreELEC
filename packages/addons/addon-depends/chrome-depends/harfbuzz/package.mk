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

PKG_NAME="harfbuzz"
PKG_VERSION="1.8.1"
PKG_SHA256="fbed6392ddb085e45e6090a9f389f72926d0e355f4b0a2ef51d35cf21686df45"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/HarfBuzz"
PKG_URL="https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain cairo freetype glib icu"
PKG_LONGDESC="HarfBuzz is an OpenType text shaping engine."
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--with-icu \
                           --disable-gtk-doc \
                           --disable-gtk-doc-html \
                           --disable-gtk-doc-pdf"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -ldl"
}
