################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="xorg-launch-helper"
PKG_VERSION="4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL-2"
PKG_SITE="https://github.com/sofar/xorg-launch-helper"
PKG_URL="http://foo-projects.org/~sofar/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_TARGET="toolchain systemd"
PKG_PRIORITY="optional"
PKG_SECTION="x11/util"
PKG_SHORTDESC="Xorg-launch-helper is a small utility that transforms the X server process (XOrg) into a daemon."
PKG_LONGDESC="Xorg-launch-helper is a small utility that transforms the X server process (XOrg) into a daemon that can be used to make applications wait with starting until XOrg is ready for X11 connections"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

post_makeinstall_target() {
  # do not install systemd services
  rm -rf $INSTALL/usr/lib
}
