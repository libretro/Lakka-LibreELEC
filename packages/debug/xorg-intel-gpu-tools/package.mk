# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xorg-intel-gpu-tools"
PKG_VERSION="1.25"
PKG_SHA256="2257a73d6a5d431dfbea4dec0dae07397b1e3269416049ced978550853616a2b"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain cairo procps-ng"
PKG_SITE="https://github.com/freedesktop/xorg-intel-gpu-tools"
PKG_URL="https://github.com/freedesktop/xorg-intel-gpu-tools/archive/igt-gpu-tools-$PKG_VERSION.tar.gz"
PKG_LONGDESC="Test suite and tools for DRM/KMS drivers"
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Dbuild_overlay=false \
                       -Dbuild_man=false \
                       -Dwith_valgrind=false \
                       -Dbuild_audio=false \
                       -Dbuild_chamelium=false \
                       -Dbuild_docs=false \
                       -Dbuild_tests=true
                       -Dwith_libdrm=auto \
                       -Dwith_libunwind=false \
                       -Dbuild_runner=false"
