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

PKG_NAME="libpciaccess"
PKG_VERSION="0.13.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://freedesktop.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS="zlib"
PKG_BUILD_DEPENDS_TARGET="toolchain util-macros zlib"
PKG_PRIORITY="optional"
PKG_SECTION="x11/lib"
PKG_SHORTDESC="libpciaccess: X.org libpciaccess library"
PKG_LONGDESC="X.org libpciaccess library."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

CFLAGS="$CFLAGS -D_LARGEFILE64_SOURCE"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_header_asm_mtrr_h=set \
                           --with-pciids-path=/usr/share \
                           --with-zlib "
