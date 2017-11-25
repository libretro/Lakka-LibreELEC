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

PKG_NAME="bash"
PKG_VERSION="4.3.46"
PKG_SHA256="fc7131bbc3139db143ec9fe03fd4e6bd3636bdf53e6956065b261f034b6af74b"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/bash/bash.html"
PKG_URL="ftp://ftp.cwru.edu/pub/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_SECTION="devel"
PKG_SHORTDESC="The GNU Bourne Again shell"
PKG_LONGDESC="The GNU Bourne Again shell"

PKG_CONFIGURE_OPTS_TARGET="--with-curses \
                           --enable-readline \
                           --without-bash-malloc \
                           --with-installed-readline"
