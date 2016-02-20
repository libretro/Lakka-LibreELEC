################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="entropy"
PKG_VERSION="0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="A simple way to add entropy at boot"
PKG_LONGDESC="A simple way to add entropy at boot"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target(){
  :
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/entropy
    cp add-entropy $INSTALL/usr/lib/entropy
    cp add-random-at-shutdown $INSTALL/usr/lib/entropy

  chmod +x $INSTALL/usr/lib/entropy/*
}

post_install() {
  enable_service add-entropy.service
  enable_service add-random-at-shutdown.service
}
