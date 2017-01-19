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

PKG_NAME="libestr"
PKG_VERSION="0.1.10"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://libestr.adiscon.com/"
PKG_URL="http://libestr.adiscon.com/files/download/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="rsyslog"
PKG_SHORTDESC="libestr: some essentials for string handling (and a bit more)"
PKG_LONGDESC="libestr: some essentials for string handling (and a bit more)"

PKG_AUTORECONF="no"
PKG_IS_ADDON="no"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
