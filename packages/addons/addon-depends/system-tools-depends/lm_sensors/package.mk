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

PKG_NAME="lm_sensors"
PKG_VERSION="3.4.0"
PKG_ARCH="arm x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://secure.netroedge.com/~lm78/"
PKG_URL="http://ftp.gwdg.de/pub/linux/misc/lm-sensors/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="lm_sensors: Hardware monitoring via the SMBus"
PKG_LONGDESC="lm_sensors is a package to get data from the SMB (System Management Bus - an i2c bus) on modern mainboards. It consists of kernel modules and users space tools to get stuff like cpu / mb temperature, voltages, fan speed..."

# TODO: PKG_MAKE_OPTS_TARGET + ETCDIR=/storage/.kodi/addons/tools.lm_sensors/data if one wants sensor3.conf..
PKG_MAKE_OPTS_TARGET="PREFIX=/usr CC=$CC AR=$AR"
PKG_MAKEINSTALL_OPTS_TARGET="PREFIX=/usr"

pre_make_target() {
  export CFLAGS="$TARGET_CFLAGS"
  export CPPFLAGS="$TARGET_CPPFLAGS"
}

makeinstall_target() {
  : # meh
}
