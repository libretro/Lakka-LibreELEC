################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="asplib"
PKG_VERSION="da66f51"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/AchimTuran/asplib"
PKG_URL="https://github.com/AchimTuran/asplib/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="audio"
PKG_SHORTDESC="asplib: Achim's Signal Processing LIBrary"
PKG_LONGDESC="asplib is a small and lightweight C++ library for digital signal processing."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

CXXFLAGS="$CXXFLAGS -DTARGET_LINUX"
