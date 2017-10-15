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

PKG_NAME="bitstream"
PKG_VERSION="1.2"
PKG_SHA256="ccfbb438711606de1fad881b58c8f134e2d82b4d53a88ea48f2d1bcb49ca5ad2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.videolan.org"
PKG_URL="http://download.videolan.org/pub/videolan/${PKG_NAME}/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="multimedia"
PKG_SHORTDESC="biTStream is a set of C headers allowing a simpler access to binary structures such as specified by MPEG, DVB, IETF, etc."
PKG_LONGDESC="biTStream is a set of C headers allowing a simpler access to binary structures such as specified by MPEG, DVB, IETF, etc."
PKG_AUTORECONF="no"

PKG_MAKEINSTALL_OPTS_TARGET="PREFIX=/usr"
