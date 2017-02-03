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
PKG_VERSION="13.2.1"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.vmware.com"
PKG_URL="http://xorg.freedesktop.org/releases/individual/driver/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain mesa glu libX11 xorg-server"
PKG_SECTION="x11/driver"
PKG_SHORTDESC="xf86-video-vmware: The Xorg driver for vmware video"
PKG_LONGDESC="xf86-video-vmware: The Xorg driver for vmware video"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-vmwarectrl-client \
                           --with-xorg-module-dir=$XORG_PATH_MODULES"
