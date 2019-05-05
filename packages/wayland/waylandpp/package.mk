# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waylandpp"
PKG_VERSION="0.2.5"
PKG_SHA256="5a4361f73d2bee65bfe54b954ce085c9bfc7bc4429ac2bdc97c10e3b84660907"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/NilsBrause/waylandpp"
PKG_URL="https://github.com/NilsBrause/waylandpp/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain pugixml:host waylandpp:host"
PKG_LONGDESC="Wayland C++ bindings"

PKG_CMAKE_OPTS_HOST="-DBUILD_SCANNER=ON \
                     -DBUILD_LIBRARIES=OFF"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SCANNER=OFF \
                       -DBUILD_LIBRARIES=ON \
                       -DCMAKE_CROSSCOMPILING=ON \
                       -DWAYLAND_SCANNERPP=${TOOLCHAIN}/bin/wayland-scanner++"
