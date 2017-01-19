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

PKG_NAME="liblogging"
PKG_VERSION="1.0.5"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.liblogging.org/"
PKG_URL="http://download.rsyslog.com/liblogging/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_SHORTDESC="liblogging"
PKG_LONGDESC="liblogging"

PKG_AUTORECONF="no"
PKG_IS_ADDON="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-man-pages \
                           --enable-static --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
