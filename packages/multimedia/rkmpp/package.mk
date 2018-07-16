# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

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
