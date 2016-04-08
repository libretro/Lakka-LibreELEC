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

PKG_NAME="xf86-video-virtualbox"
PKG_VERSION="5.0.20"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.virtualbox.org"
PKG_URL="${DISTRO_SRC}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libXcomposite libXdamage libXfixes libXext libX11 libxcb libXau"
PKG_PRIORITY="optional"
PKG_SECTION="x11/driver"
PKG_SHORTDESC="xf86-video-virtualbox: The Xorg driver for virtualbox video"
PKG_LONGDESC="xf86-video-virtualbox: The Xorg driver for virtualbox video"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing todo
}

makeinstall_target() {
  mkdir -p $INSTALL/$XORG_PATH_MODULES/drivers
    cp -P lib/VBoxGuestAdditions/vboxvideo_drv_118.so $INSTALL/$XORG_PATH_MODULES/drivers/vboxvideo_drv.so

  mkdir -p $INSTALL/usr/lib/dri
    cp -P lib/VBoxOGL.so $INSTALL/usr/lib/dri/vboxvideo_dri.so

  mkdir -p $INSTALL/usr/lib
    cp -aP lib/* $INSTALL/usr/lib

  mkdir -p $INSTALL/etc/X11
    cp $PKG_DIR/config/*.conf $INSTALL/etc/X11
}
