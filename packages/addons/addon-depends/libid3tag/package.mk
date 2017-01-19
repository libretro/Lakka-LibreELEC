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

PKG_NAME="libid3tag"
PKG_VERSION="0.15.1b"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.mars.org/home/rob/proj/mpeg/"
PKG_URL="$SOURCEFORGE_SRC/mad/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_SECTION="audio"
PKG_SHORTDESC="library for id3 tagging"
PKG_LONGDESC="library for id3 tagging"
PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

PKG_MAINTAINER="Lukas Sabota (LTsmooth42@gmail.com)"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"
