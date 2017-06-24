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

PKG_NAME="dispmanx_vnc"
PKG_VERSION="78e6673"
PKG_REV="102"
PKG_ARCH="arm"
PKG_ADDON_PROJECTS="RPi RPi2"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/patrikolausson/dispmanx_vnc"
PKG_URL="https://github.com/patrikolausson/dispmanx_vnc/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libvncserver bcm2835-bootloader bcm2835-driver libconfig openssl"
PKG_SECTION="service/system"
PKG_SHORTDESC="Raspberry Pi VNC: a Virtual Network Computing server for Raspberry Pi"
PKG_LONGDESC="Raspberry Pi VNC ($PKG_VERSION) is a Virtual Network Computing (VNC) server for Raspberry Pi using dispmanx"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Raspberry Pi VNC"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

pre_make_target() {
  export SYSROOT_PREFIX
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -p $PKG_BUILD/dispmanx_vncserver $ADDON_BUILD/$PKG_ADDON_ID/bin
}
