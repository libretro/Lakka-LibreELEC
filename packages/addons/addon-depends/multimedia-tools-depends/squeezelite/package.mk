################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="squeezelite"
PKG_VERSION="a3d95ec"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/ralph-irving/squeezelite"
PKG_URL="https://github.com/ralph-irving/squeezelite/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain faad2 ffmpeg flac libmad libvorbis mpg123 soxr"
PKG_SECTION="tools"
PKG_SHORTDESC="squeezelite"
PKG_LONGDESC="A client for the Logitech Media Server"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  OPTS="-DDSD -DFFMPEG -DRESAMPLE -DVISEXPORT"
  CFLAGS="$CFLAGS $OPTS"
  LDFLAGS="$LDFLAGS -lasound -lpthread -lm -lrt -lFLAC -lmad -lvorbisfile -lfaad -lmpg123"
}

makeinstall_target() {
  :
}
