################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="libopenmpt"
PKG_VERSION="0.2.5787-beta16"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://lib.openmpt.org/libopenmpt/"
PKG_URL="http://lib.openmpt.org/files/libopenmpt/src/${PKG_NAME}-${PKG_VERSION}-autotools.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}-${PKG_VERSION//-beta*/}-autotools"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="audio"
PKG_SHORTDESC="libopenmpt: renders mod music files as raw audio data, for playing or conversion."
PKG_LONGDESC="libopenmpt renders mod music files as raw audio data, for playing or conversion."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
			   --disable-shared \
			   --without-portaudio \
			   --without-portaudiocpp"
