# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="googletest"
PKG_VERSION="1.14.0"
PKG_SHA256="8ad598c73ad796e0d8280b082cebd82a630d73e73cd3c70057938a6501bba5d7"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/google/googletest"
PKG_URL="https://github.com/google/googletest/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host cmake:host"
PKG_LONGDESC="Google Testing and Mocking Framework"
PKG_TOOLCHAIN="cmake-make"
