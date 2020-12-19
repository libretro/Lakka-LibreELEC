# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="harfbuzz"
PKG_VERSION="2.7.4"
PKG_SHA256="6ad11d653347bd25d8317589df4e431a2de372c0cf9be3543368e07ec23bb8e7"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/HarfBuzz"
PKG_URL="https://github.com/harfbuzz/harfbuzz/releases/download/$PKG_VERSION/harfbuzz-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain cairo freetype glib icu"
PKG_LONGDESC="HarfBuzz is an OpenType text shaping engine."
PKG_TOOLCHAIN="meson"
PKG_DEPENDS_CONFIG="icu"

PKG_MESON_OPTS_TARGET="-Dcairo=enabled \
                       -Ddocs=disabled \
                       -Dfontconfig=enabled \
                       -Dfreetype=enabled \
                       -Dglib=enabled \
                       -Dgobject=disabled \
                       -Dgraphite=disabled \
                       -Dicu=enabled"
