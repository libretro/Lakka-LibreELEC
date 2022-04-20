# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="media-driver"
PKG_VERSION="22.4.0"
PKG_SHA256="f070527b141174970a17195d0225ed43693c39fec83cd5e6d0effaa88e2a5553"
PKG_ARCH="x86_64"
PKG_LICENSE="MIT"
PKG_SITE="https://01.org/linuxmedia"
PKG_URL="https://github.com/intel/media-driver/archive/intel-media-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libva libdrm gmmlib"
PKG_LONGDESC="media-driver: The Intel(R) Media Driver for VAAPI is a new VA-API (Video Acceleration API) user mode driver supporting hardware accelerated decoding, encoding, and video post processing for GEN based graphics hardware."

PKG_CMAKE_OPTS_TARGET="-DBUILD_CMRTLIB=OFF \
                       -DBUILD_KERNELS=ON \
                       -DBUILD_TYPE=release \
                       -DENABLE_NONFREE_KERNELS=ON \
                       -DMEDIA_RUN_TEST_SUITE=OFF"
