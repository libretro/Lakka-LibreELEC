# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xorg-intel-gpu-tools"
PKG_VERSION="504367d33b787de2ba8e007a5b620cfd6f0b3074"
PKG_SHA256="3e118ce6ab58b506de88ab158e9e630b3db9ab75b14cd0c4a8019548d2d0c320"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain cairo procps-ng"
PKG_SITE="https://github.com/freedesktop/xorg-intel-gpu-tools"
PKG_URL="https://github.com/freedesktop/xorg-intel-gpu-tools/archive/$PKG_VERSION.tar.gz"
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
