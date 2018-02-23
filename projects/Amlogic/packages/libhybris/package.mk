################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="libhybris"
PKG_VERSION="070c3ab"
PKG_SHA256="070dcf48aa424c1c56c1d95f5116051a22a76bd5ac0c877febf04b63d9559ea2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libhybris/libhybris"
PKG_URL="https://github.com/libhybris/libhybris/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="$PKG_NAME-$PKG_VERSION*/hybris"
PKG_DEPENDS_TARGET="toolchain android-headers"
PKG_SECTION="devel"
PKG_SHORTDESC="libhybris: Allows to run bionic-based HW adaptations in glibc systems - libs"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-arch=$TARGET_ARCH \
                           --with-default-egl-platform=fbdev \
                           --with-android-headers=$BUILD/android-headers-25 \
                           --with-default-hybris-ld-library-path=/system/lib \
                           --enable-mali-quirks"
