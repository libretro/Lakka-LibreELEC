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

PKG_NAME="xf86-video-amdgpu"
PKG_VERSION="18.0.1"
PKG_SHA256="7484682ccb403b3ca9e26d1c980572f08cdfa3469e2b2c9a9affc3d51b52691b"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain xorg-server"
PKG_SECTION="x11/driver"
PKG_SHORTDESC="xf86-video-amdgpu - AMD Radeon video driver for the Xorg X server"
PKG_LONGDESC="AMD Xorg video driver"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-udev \
                           --enable-glamor \
                           --with-xorg-module-dir=$XORG_PATH_MODULES"

post_makeinstall_target() {
  rm -r $INSTALL/usr/share
  mkdir -p $INSTALL/etc/X11
    cp $PKG_BUILD/conf/10-amdgpu.conf $INSTALL/etc/X11/xorg-amdgpu.conf
}
