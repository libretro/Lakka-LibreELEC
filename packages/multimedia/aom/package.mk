################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="aom"
PKG_VERSION="96ee0eb"
PKG_SHA256="37c8d930cc105ccad4987c65751400fc42819b77fd487c9ef19cadee0c95a2d8"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://www.webmproject.org"
PKG_URL="http://repo.or.cz/aom.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="multimedia"
PKG_LONGDESC="AV1 Codec Library"

PKG_CMAKE_OPTS_TARGET="-DENABLE_CCACHE=1 \
                       -DENABLE_DOCS=0 \
                       -DENABLE_TOOLS=0"
