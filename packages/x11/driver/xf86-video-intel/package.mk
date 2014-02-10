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

PKG_NAME="xf86-video-intel"
PKG_VERSION="2.99.910"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://intellinuxgraphics.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libXcomposite util-macros fontsproto systemd xorg-server"
PKG_PRIORITY="optional"
PKG_SECTION="x11/driver"
PKG_SHORTDESC="xf86-video-intel: The Xorg driver for Intel video chips"
PKG_LONGDESC="The Xorg driver for Intel i810, i815, 830M, 845G, 852GM, 855GM, 865G, 915G, 915GM and 965G video chips."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-udev \
                           --enable-dri \
                           --enable-kms --enable-kms-only \
                           --disable-ums --disable-ums-only \
                           --enable-sna \
                           --enable-uxa \
                           --disable-xvmc \
                           --disable-glamor \
                           --disable-xaa \
                           --disable-dga \
                           --disable-async-swap \
                           --with-xorg-module-dir=$XORG_PATH_MODULES"

pre_configure_target() {
# TODO: xf86-video-intel-2.21.5 dont link with LTO enabled
  strip_lto
}
