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

PKG_NAME="liblognorm"
PKG_VERSION="2.0.1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.liblognorm.com/"
PKG_URL="http://www.liblognorm.com/files/download/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="rsyslog"
PKG_SHORTDESC="liblognorm"
PKG_LONGDESC="liblognorm"

PKG_AUTORECONF="no"
PKG_IS_ADDON="no"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
