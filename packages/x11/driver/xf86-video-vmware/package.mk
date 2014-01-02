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

PKG_NAME="xf86-video-vmware"
PKG_VERSION="45b2457516a9db4bd1d60fbb24a1efbe2d9dd932"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.vmware.com"
PKG_URL="http://cgit.freedesktop.org/xorg/driver/xf86-video-vmware/snapshot/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="libX11 Mesa glu open-vm-tools"
PKG_BUILD_DEPENDS_TARGET="toolchain Mesa glu xorg-server"
PKG_PRIORITY="optional"
PKG_SECTION="x11/driver"
PKG_SHORTDESC="xf86-video-vmware: The Xorg driver for vmware video"
PKG_LONGDESC="xf86-video-vmware: The Xorg driver for vmware video"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-vmwarectrl-client \
                           --with-xorg-module-dir=$XORG_PATH_MODULES"
