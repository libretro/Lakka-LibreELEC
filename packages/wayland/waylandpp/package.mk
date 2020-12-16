# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waylandpp"
PKG_VERSION="0.2.8"
PKG_SHA256="e7f486165d3568c3558b5c7099133aea4a285b82820eeafad329fc10271c654d"
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
