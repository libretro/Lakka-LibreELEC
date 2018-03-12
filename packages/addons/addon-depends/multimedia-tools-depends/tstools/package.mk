################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="tstools"
PKG_VERSION="1.11"
PKG_SHA256="4e207ad7298ec421c6710e3024147b486320d792cec2dbd34efb7e6d9e96230a"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://tstools.berlios.de/"
PKG_URL="$SOURCEFORGE_SRC/project/tstools.berlios/tstools-1_11.tgz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="command line tools for working with MPEG data"
PKG_LONGDESC="This is a set of cross-platform command line tools for working with MPEG data."
PKG_BUILD_FLAGS="-parallel"

make_target() {
  make CROSS_COMPILE=$TARGET_PREFIX
}

makeinstall_target() {
  : # nop
}
