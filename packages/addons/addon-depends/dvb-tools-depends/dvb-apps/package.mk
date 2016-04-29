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

PKG_NAME="dvb-apps"
PKG_VERSION="3d43b280298c"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.linuxtv.org/wiki/index.php/LinuxTV_dvb-apps"
PKG_URL="http://linuxtv.org/hg/dvb-apps/archive/${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="Digitial Video Broadcasting (DVB) applications"
PKG_LONGDESC="Applications and utilities geared towards the initial setup, testing and operation of an DVB device supporting the DVB-S, DVB-C, DVB-T, and ATSC standards."
PKG_AUTORECONF="no"

make_target() {
  make -C lib
  make -C util
}

makeinstall_target() {
  : # nop
}
