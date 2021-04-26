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

PKG_NAME="joycond"
PKG_VERSION="1"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="toolchain cmake:host gcc-linaro-aarch64-linux-gnu:host"
PKG_SITE="https://github.com/DanielOgorchock/joycond"
PKG_URL="https://github.com/DanielOgorchock/joycond/archive/master.tar.gz"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="cmake-make"

post_makeinstall_target() {
  rm -r $INSTALL/etc/modules-load.d
  mv $INSTALL/lib/* $INSTALL/usr/lib/ && rmdir $INSTALL/lib
  mv $INSTALL/etc/systemd $INSTALL/usr/lib/systemd
  mkdir -p $INSTALL/usr/lib/systemd/system/multi-user.target.wants
  mkdir -p $INSTALL/usr/lib/udev
  mv $INSTALL/usr/lib/rules.d $INSTALL/usr/lib/udev/
  sed -i 's|WorkingDirectory=/root|WorkingDirectory=/var|g' $INSTALL/usr/lib/systemd/system/joycond.service
  ln -s $INSTALL/usr/lib/systemd/system/joycond.service $INSTALL/usr/lib/systemd/system/multi-user.target.wants/joycond.service
}
