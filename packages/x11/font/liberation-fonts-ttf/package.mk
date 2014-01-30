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

PKG_NAME="liberation-fonts-ttf"
PKG_VERSION="2.00.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OFL1_1"
PKG_SITE="https://www.redhat.com/promo/fonts/"
PKG_URL="https://fedorahosted.org/releases/l/i/liberation-fonts/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_PRIORITY="optional"
PKG_SECTION="x11/fonts"
PKG_SHORTDESC="liberation-fonts: High quality "open-sourced" vector fonts"
PKG_LONGDESC="This packages included the high-quality and open-sourced TrueType vector fonts released by RedHat."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing to make
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/fonts/liberation
    cp *.ttf $INSTALL/usr/share/fonts/liberation
}

post_install() {
  mkfontdir $INSTALL/usr/share/fonts/liberation
  mkfontscale $INSTALL/usr/share/fonts/liberation
}
