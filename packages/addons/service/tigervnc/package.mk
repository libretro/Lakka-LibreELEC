################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-2017 Team LibreELEC
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

PKG_NAME="tigervnc"
PKG_VERSION="1.7.1"
PKG_REV="101"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="http://www.tigervnc.org"
PKG_URL="https://github.com/TigerVNC/tigervnc/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host libX11 libXext libXtst zlib libjpeg-turbo"
PKG_SECTION="service"
PKG_SHORTDESC="$PKG_ADDON_NAME server"
PKG_LONGDESC="$PKG_ADDON_NAME ($PKG_VERSION) is a high-performance, platform-neutral implementation of Virtual Network Computing, a client/server application that allows users to launch and interact with graphical applications on remote machines"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="TigerVNC"
PKG_ADDON_TYPE="xbmc.service"

PKG_CMAKE_OPTS_TARGET="-DBUILD_VIEWER=off"

makeinstall_target() {
  : # nothing to do
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/unix/vncconfig/vncconfig     \
     $PKG_BUILD/.$TARGET_NAME/unix/vncpasswd/vncpasswd     \
     $PKG_BUILD/.$TARGET_NAME/unix/x0vncserver/x0vncserver \
     $ADDON_BUILD/$PKG_ADDON_ID/bin/
}
