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

PKG_NAME="toolchain"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="make:host xz:host sed:host pkg-config:host autoconf:host automake:host libtool:host intltool:host autoconf-archive:host gcc:host bison:host flex:host cmake:host scons:host yasm:host"
PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="toolchain: OpenELEC.tv' toolchain"
PKG_LONGDESC="a crosscompiling toolchain to compile all packages"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
