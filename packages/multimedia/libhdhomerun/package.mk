################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="libhdhomerun"
PKG_VERSION="20171221"
PKG_SHA256="08e22db43621b96260086a834e7c586cb92aa4b3ec30adf0adf3c7588d527ff8"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.silicondust.com"
PKG_URL="http://download.silicondust.com/hdhomerun/${PKG_NAME}_${PKG_VERSION}.tgz"
PKG_SOURCE_DIR="$PKG_NAME"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="driver"
PKG_SHORTDESC="The library provides functionality to setup the HDHomeRun, change channels, setup PID filtering, get signal quality and so on."
PKG_LONGDESC="The library provides functionality to setup the HDHomeRun, change channels, setup PID filtering, get signal quality and so on."

PKG_MAKE_OPTS_TARGET="CROSS_COMPILE=$TARGET_PREFIX"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -PR hdhomerun_config $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/lib/
    cp -PR libhdhomerun.so $INSTALL/usr/lib/

  mkdir -p $SYSROOT_PREFIX/usr/include/hdhomerun
    cp *.h $SYSROOT_PREFIX/usr/include/hdhomerun

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp libhdhomerun.so $SYSROOT_PREFIX/usr/lib
}
