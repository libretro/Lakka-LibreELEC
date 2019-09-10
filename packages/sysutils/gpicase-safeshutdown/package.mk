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

PKG_NAME="gpicase-safeshutdown"
PKG_VERSION="1.0"
PKG_ARCH="arm"
PKG_URL=""
PKG_DEPENDS_TARGET="Python python-gpiozero python-colorzero"
PKG_SECTION="system"
PKG_SHORTDESC="gpicase-safeshutdown: GPICase safe shutdown script"
PKG_LONGDESC="GPICase safe shutdown script."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp $PKG_DIR/scripts/* $INSTALL/usr/bin
}

post_install() {
  enable_service gpicase-safeshutdown.service
}
