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

PKG_NAME="libva-driver-intel"
PKG_VERSION="1.3.0"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://freedesktop.org/wiki/Software/vaapi"
PKG_URL="http://cgit.freedesktop.org/vaapi/intel-driver/snapshot/intel-driver-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libva libdrm"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libva-driver-intel: Intel G45+ driver for VAAPI"
PKG_LONGDESC="libva-driver-intel: Intel G45+ driver for VAAPI"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules --with-drivers-path=/usr/lib/va"

unpack () {
  if [ -d $BUILD/$PKG_NAME-$PKG_VERSION ]; then
    rm -rf $BUILD/$PKG_NAME-$PKG_VERSION
  fi

  tar -xzf $SOURCES/$PKG_NAME/intel-driver-$PKG_VERSION.tar.gz -C $BUILD
  mv $BUILD/intel-driver-$PKG_VERSION $BUILD/$PKG_NAME-$PKG_VERSION
}
