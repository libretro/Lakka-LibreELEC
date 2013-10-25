################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2011 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2011-2011 Gregor Fuis (gujs@openelec.tv)
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
#  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
#  http://www.gnu.org/copyleft/gpl.htmlLooking for the latest version?
################################################################################

PKG_NAME="hd-idle"
PKG_VERSION="1.04"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://hd-idle.sourceforge.net/"
PKG_URL="http://downloads.sourceforge.net/project/hd-idle/${PKG_NAME}-${PKG_VERSION}.tgz"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="hd-idle is a [Linux] utility program for spinning-down external disks after a period of idle time."
PKG_LONGDESC="hd-idle is a utility program for spinning-down external disks after a period of idle time. Since most external IDE disk enclosures don't support setting the IDE idle timer, a program like hd-idle is required to spin down idle disks automatically."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
  mv $ROOT/$BUILD/$PKG_NAME $ROOT/$BUILD/$PKG_NAME-$PKG_VERSION
}
