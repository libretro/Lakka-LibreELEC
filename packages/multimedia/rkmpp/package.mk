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

PKG_NAME="rkmpp"
PKG_VERSION="c8a41a6"
PKG_SHA256="01b84eecde7cae98035ecce866b48f903f9deaa7e19b048ff9cb87edf6446659"
PKG_ARCH="arm aarch64"
PKG_LICENSE="APL"
PKG_SITE="https://github.com/rockchip-linux/mpp"
PKG_URL="https://github.com/rockchip-linux/mpp/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="mpp-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain libdrm"
PKG_SECTION="multimedia"
PKG_SHORTDESC="rkmpp: Rockchip Media Process Platform (MPP) module"
PKG_LONGDESC="rkmpp: Rockchip Media Process Platform (MPP) module"

if [ "$DEVICE" = "RK3328" -o "$DEVICE" = "RK3399" ]; then
  PKG_ENABLE_VP9D="ON"
else
  PKG_ENABLE_VP9D="OFF"
fi

PKG_CMAKE_OPTS_TARGET="-DRKPLATFORM=ON \
                       -DENABLE_AVSD=OFF \
                       -DENABLE_H263D=OFF \
                       -DENABLE_H264D=ON \
                       -DENABLE_H265D=ON \
                       -DENABLE_MPEG2D=ON \
                       -DENABLE_MPEG4D=ON \
                       -DENABLE_VP8D=ON \
                       -DENABLE_VP9D=$PKG_ENABLE_VP9D \
                       -DENABLE_JPEGD=OFF \
                       -DHAVE_DRM=ON"
