# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waylandpp"
PKG_VERSION="0.1.6"
PKG_SHA256="33d3ec385704c5545fb50d2283aabf4ef26aaaf3e416b292e650fea67c430d23"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/NilsBrause/waylandpp"
PKG_URL="https://github.com/NilsBrause/waylandpp/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain waylandpp:host"
PKG_LONGDESC="Wayland C++ bindings"

PKG_CMAKE_OPTS_HOST="-DBUILD_SCANNER=ON \
                     -DBUILD_LIBRARIES=OFF"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SCANNER=OFF \
                       -DBUILD_LIBRARIES=ON \
                       -DCMAKE_CROSSCOMPILING=ON \
                       -DWAYLAND_SCANNERPP=$TOOLCHAIN/bin/wayland-scanner++"
