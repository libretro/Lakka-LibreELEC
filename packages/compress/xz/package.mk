################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="xz"
PKG_VERSION="5.0.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://tukaani.org/xz/"
PKG_URL="http://tukaani.org/xz/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST=""
PKG_BUILD_DEPENDS_HOST="ccache:host"
PKG_PRIORITY="optional"
PKG_SECTION="toolchain/archivers"
PKG_SHORTDESC="xz: a free general-purpose data compression software with high compression ratio."
PKG_LONGDESC="XZ Utils is free general-purpose data compression software with high compression ratio. XZ Utils were written for POSIX-like systems, but also work on some not-so-POSIX systems. XZ Utils are the successor to LZMA Utils."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="--disable-shared --enable-static \
                         --disable-lzmadec \
                         --disable-lzmainfo \
                         --enable-lzma-links \
                         --disable-scripts \
                         --disable-nls"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"
