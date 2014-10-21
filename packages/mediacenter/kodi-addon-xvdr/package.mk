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

PKG_NAME="kodi-addon-xvdr"
PKG_VERSION="2bf2563"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/pipelka/xbmc-addon-xvdr"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib kodi"
PKG_PRIORITY="optional"
PKG_SECTION="mediacenter"
PKG_SHORTDESC="XVDR addon for Kodi"
PKG_LONGDESC="This addon allows Kodi PVR to connect to the VDR server."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr/share/kodi"

export CXXFLAGS="$CXXFLAGS -DZLIB_INTERNAL=1"

pre_make_target() {
  # dont build parallel
  MAKEFLAGS=-j1
}

post_makeinstall_target() {
  if [ "$DEBUG" != yes ]; then
    $STRIP $INSTALL/usr/share/kodi/addons/pvr.vdr.xvdr/XBMC_VDR_xvdr.pvr
  fi
}
