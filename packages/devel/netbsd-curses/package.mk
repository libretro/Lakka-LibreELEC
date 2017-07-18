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

PKG_NAME="netbsd-curses"
PKG_VERSION="4c156be"
PKG_SHA256="3605719ae3035e7e246d8375fb1ad0faed8d3a42e80b991e046345730aad9df8"
PKG_ARCH="any"
PKG_SITE="https://github.com/sabotage-linux/netbsd-curses"
PKG_URL="https://github.com/sabotage-linux/netbsd-curses/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="netbsd-libcurses portable edition"
PKG_LONGDESC="netbsd-libcurses portable edition"

pre_make_target() {
  CFLAGS="$CFLAGS -fPIC -I${PKG_BUILD}/libcurses"
}

make_target() {
  make HOSTCC="$HOST_CC" PREFIX=/usr all-static
}

makeinstall_target() {
  make HOSTCC="$HOST_CC" PREFIX=$SYSROOT_PREFIX/usr install-static
}
