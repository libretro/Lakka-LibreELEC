################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="faad2"
PKG_VERSION="2.8.8"
PKG_SHA256="985c3fadb9789d2815e50f4ff714511c79c2710ac27a4aaaf5c0c2662141426d"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.audiocoding.com"
PKG_URL="https://downloads.sourceforge.net/sourceforge/faac/faad2-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="audio"
PKG_LONGDESC="An MPEG-4 AAC decoder"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --without-drm \
                           --with-gnu-ld \
                           --without-mpeg4ip \
                           --without-xmms"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
