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

PKG_NAME="Mali_OpenGL_ES_SDK"
PKG_VERSION="v2.4.4"
PKG_REVISION="ed0c8beb-298d-43bc-8d1a-0c99ed94eee6"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_TOOLCHAIN="manual"
PKG_SITE="https://developer.arm.com/products/software/mali-sdks/opengl-es/downloads"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/mali-sdk/v2.4.4/Mali_OpenGL_ES_SDK_v2.4.4.ef7d5a_Linux_x64.tar.gz"
PKG_SOURCE_DIR="Mali_OpenGL_ES_SDK_v2.4.4"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="MALI headers for XU[34]."
PKG_LONGDESC="MALI headers for XU[34]."
PKG_USE_CMAKE="no"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR $PKG_BUILD/inc/* $SYSROOT_PREFIX/usr/include
    cp -PR $PKG_BUILD/simple_framework/inc/mali/* $SYSROOT_PREFIX/usr/include
}
