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

PKG_NAME="dvblast"
PKG_VERSION="77cfaa8"
PKG_SHA256="b78eaec73addb328384bf8acb93a1b6a6334f4fa47914f98b91b4cd4fc00b639"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.videolan.org/projects/dvblast.html"
PKG_URL="http://repo.or.cz/dvblast.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain bitstream libev"
PKG_SECTION="tools"
PKG_SHORTDESC="DVBlast is a simple and powerful MPEG-2/TS demux and streaming application"
PKG_LONGDESC="DVBlast is a simple and powerful MPEG-2/TS demux and streaming application"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -lm"
}

makeinstall_target() {
 :
}
