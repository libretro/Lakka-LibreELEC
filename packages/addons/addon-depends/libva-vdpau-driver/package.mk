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

PKG_NAME="libva-vdpau-driver"
PKG_VERSION="0.7.4"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://freedesktop.org/wiki/Software/vaapi"
PKG_URL="http://freedesktop.org/software/vaapi/releases/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libva libvdpau mesa"
PKG_SECTION="graphics"
PKG_SHORTDESC="VDPAU backend for VA API"
PKG_LONGDESC="VDPAU backend for VA API"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/va/s3g_drv_video.so
}
