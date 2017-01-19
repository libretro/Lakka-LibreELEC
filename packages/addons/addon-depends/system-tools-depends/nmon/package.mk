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

PKG_NAME="nmon"
PKG_VERSION="411b08f"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/axibase/nmon"
PKG_URL="https://github.com/axibase/nmon/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain netbsd-curses"
PKG_SECTION="tools"
PKG_SHORTDESC="Systems administrator, tuner, benchmark tool gives you a huge amount of important performance information in one go"
PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

make_target() {
  case $ARCH in
    x86_64)
      arch="X86"
      ;;
    *)
      arch="arm"
      ;;
  esac
  CFLAGS="$CFLAGS -g -O3 -Wall -D JFS -D GETUSER -D LARGEMEM"
  LDFLAGS="$LDFLAGS -lncurses -ltermcap -lm -g"
  $CC -o nmon lmon*.c $CFLAGS $LDFLAGS -D $arch -D KERNEL_2_6_18
}

makeinstall_target() {
  :
}
