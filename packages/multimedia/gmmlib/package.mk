# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gmmlib"
PKG_VERSION="21.2.2"
PKG_SHA256="58ef6ac98fb7acc0002c779ce784926da6089a450f3d752ef27268664fe037cc"
PKG_ARCH="x86_64"
PKG_LICENSE="MIT"
PKG_SITE="https://01.org/linuxmedia"
PKG_URL="https://github.com/intel/gmmlib/archive/intel-gmmlib-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="gmmlib: The Intel(R) Graphics Memory Management Library provides device specific and buffer management for the Intel(R) Graphics Compute Runtime for OpenCL(TM) and the Intel(R) Media Driver for VAAPI."

PKG_CMAKE_OPTS_TARGET="-DRUN_TEST_SUITE=OFF"
