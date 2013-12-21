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

PKG_NAME="xf86-video-nouveau"
PKG_VERSION="1.0.9"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://cgit.freedesktop.org/nouveau/xf86-video-nouveau/snapshot/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS="libXrandr libXrender libdrm libXext libpciaccess systemd Mesa glu"
PKG_BUILD_DEPENDS_TARGET="toolchain util-macros libXrandr libXrender libdrm libXext libpciaccess systemd Mesa glu xorg-server"
PKG_PRIORITY="optional"
PKG_SECTION="x11/driver"
PKG_SHORTDESC="xf86-video-nouveau: Nouveau display driver (experimental)"
PKG_LONGDESC="This driver for the X.Org X server (see xserver-xorg for a further description) provides support for NVIDIA Riva, TNT, GeForce, and Quadro cards. Although the nouveau project aims to provide full 3D support it is not yet complete, and these packages do not include any 3D support. Users requiring 3D support should use the non-free "nvidia" driver."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--with-xorg-module-dir=$XORG_PATH_MODULES"

post_makeinstall_target() {
  mkdir -p $INSTALL/etc/X11
    cp $PKG_DIR/config/*.conf $INSTALL/etc/X11
}
