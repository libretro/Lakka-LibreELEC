################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
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

PKG_NAME="imx-gpu-g2d"
PKG_VERSION="6.2.2.p0"
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.freescale.com"
PKG_URL="http://repository.timesys.com/buildsources/g/gpu-viv-g2d/gpu-viv-g2d-$PKG_VERSION/gpu-viv-g2d-$PKG_VERSION.bin"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="graphics"
PKG_SHORTDESC="imx-gpu-g2d: 2D graphics library"
PKG_LONGDESC="imx-gpu-g2d: 2D graphics library"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
 : # nothing to make all binary
}

makeinstall_target() {
  cp -PRv g2d/usr/include/* $SYSROOT_PREFIX/usr/include

  LIBS_COPY="g2d/usr/lib/libg2d*.so*"

  mkdir -p $SYSROOT_PREFIX/usr/lib
  cp -PRv $LIBS_COPY $SYSROOT_PREFIX/usr/lib

  mkdir -p $INSTALL/usr/lib
  cp -PRv $LIBS_COPY $INSTALL/usr/lib
}
