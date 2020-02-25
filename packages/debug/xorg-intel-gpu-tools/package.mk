# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xorg-intel-gpu-tools"
PKG_VERSION="1.24"
PKG_SHA256="d8db92f1151e46b74b149bb9efa745f73c080c12841bb2b9de22d65403dc601f"
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
