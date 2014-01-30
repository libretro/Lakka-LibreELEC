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

PKG_NAME="libmodplug"
PKG_VERSION="0.8.8.4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://modplug-xmms.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/modplug-xmms/libmodplug/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="audio"
PKG_SHORTDESC="libmodplug: renders mod music files as raw audio data, for playing or conversion."
PKG_LONGDESC="libmodplug renders mod music files as raw audio data, for playing or conversion. libmodplug is based on the fast and high quality mod playing code written and released to the public domain by Olivier Lapicque. mod, .s3m, .it, .xm, and a number of lesser-known formats are supported. Optional features include high-quality resampling, bass expansion, surround and reverb."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"
