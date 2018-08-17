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

PKG_NAME="rgbds"
PKG_VERSION="d778b8e"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/rednex/rgbds"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_HOST="toolchain libpng:host"
PKG_SHORTDESC="Rednex Game Boy Development System"
PKG_LONGDESC="Rednex Game Boy Development System"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

makeinstall_host() {
  cp $PKG_BUILD/rgbasm $TOOLCHAIN/bin
  cp $PKG_BUILD/rgbfix $TOOLCHAIN/bin
  cp $PKG_BUILD/rgbgfx $TOOLCHAIN/bin
  cp $PKG_BUILD/rgblink $TOOLCHAIN/bin
}
