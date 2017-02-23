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

PKG_NAME="mkbootimg"
PKG_VERSION="6668fc2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://android.googlesource.com/platform/system/core/+/master/mkbootimg/"
PKG_URL="https://github.com/codesnake/mkbootimg/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST=""
PKG_SECTION="tools"
PKG_SHORTDESC="mkbootimg: Creates kernel boot images for Android"
PKG_LONGDESC="mkbootimg: Creates kernel boot images for Android"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

makeinstall_host() {
  mkdir -p $SYSROOT_PREFIX/usr/include
  cp mkbootimg $TOOLCHAIN/bin/
}
