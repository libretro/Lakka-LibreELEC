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

. "$ROOT/packages/databases/sqlite/package.mk"

PKG_NAME="mono_sqlite"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain sqlite"
PKG_SHORTDESC="sqlite for mono"
PKG_LONGDESC="libsqlite built shared for mono"

PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-static --enable-shared"

unpack() {
  mkdir -p $PKG_BUILD
  cp -r $(get_build_dir sqlite)/* $PKG_BUILD/
}
