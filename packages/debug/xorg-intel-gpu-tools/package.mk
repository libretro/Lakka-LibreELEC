# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xorg-intel-gpu-tools"
PKG_VERSION="1.26"
PKG_SHA256="36d4193b9f22fbb4834ec97be3bb6322ec901e20f7be018f0a50d3eb03ec9bb7"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain cairo procps-ng"
PKG_SITE="https://gitlab.freedesktop.org/drm/igt-gpu-tools"
PKG_URL="https://www.x.org/releases/individual/app/igt-gpu-tools-${PKG_VERSION}.tar.xz"
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
