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

# TODO: libass-0.11.1 fails to render subtitles sometimes, see
# http://forum.xbmc.org/showthread.php?tid=184866&pid=1669869#pid1669869

PKG_NAME="libass"
PKG_VERSION="0.10.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://code.google.com/p/libass/"
PKG_URL="http://libass.googlecode.com/files/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain freetype fontconfig enca fribidi"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libass: a portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format."
PKG_LONGDESC="libass is a portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format. It is mostly compatible with VSFilter"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-test \
            --enable-enca \
            --enable-fontconfig \
            --disable-harfbuzz \
            --disable-silent-rules \
            --with-gnu-ld"
