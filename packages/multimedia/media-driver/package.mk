# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="media-driver"
PKG_VERSION="22.2.0"
PKG_SHA256="99d6866fdc31a554a4238635b3d09553d97fb4cfdd3a034aa0767f787304bc0f"
PKG_ARCH="x86_64"
PKG_LICENSE="MIT"
PKG_SITE="https://01.org/linuxmedia"
PKG_URL="https://github.com/intel/media-driver/archive/intel-media-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libva libdrm gmmlib"
PKG_LONGDESC="media-driver: The Intel(R) Media Driver for VAAPI is a new VA-API (Video Acceleration API) user mode driver supporting hardware accelerated decoding, encoding, and video post processing for GEN based graphics hardware."

PKG_CMAKE_OPTS_TARGET="-DBUILD_CMRTLIB=OFF -DENABLE_NONFREE_KERNELS=ON -DBUILD_KERNELS=ON -DBYPASS_MEDIA_ULT=yes"
