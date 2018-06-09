################################################################################
#      This file is part of LibreELEC - https://www.libreelec.tv
#      Copyright (C) 2018 Team LibreELEC
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

PKG_NAME="kmscube"
PKG_VERSION="98f31bf"
PKG_SHA256="78b52b9e606f0d3444e10ea2ed7c0c03a87f1ad2ef99e35036551395faade041"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://cgit.freedesktop.org/mesa/kmscube"
PKG_URL="https://cgit.freedesktop.org/mesa/kmscube/snapshot/$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Example KMS/GBM/EGL application"
PKG_TOOLCHAIN="autotools"

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
elif [ "$OPENGL_SUPPORT" = "yes" ]; then
  echo "kmscube only supports OpenGLESv2"
  exit 0
fi
