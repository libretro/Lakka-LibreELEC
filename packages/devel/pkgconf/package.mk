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

PKG_NAME="pkgconf"
PKG_VERSION="0.9.6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/pkgconf/pkgconf"
PKG_URL="https://github.com/pkgconf/pkgconf/archive/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host gettext:host automake:host"
PKG_PRIORITY="optional"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="pkgconf: compiler and linker configuration for development frameworks"
PKG_LONGDESC="pkgconf provides compiler and linker configuration for development frameworks"

PKG_SOURCE_DIR="${PKG_NAME}-${PKG_NAME}-${PKG_VERSION}"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_host() {
  sh autogen.sh
}

post_makeinstall_host() {
  ln -sf pkgconf $ROOT/$TOOLCHAIN/bin/pkg-config
}
