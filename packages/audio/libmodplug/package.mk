# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libmodplug"
PKG_VERSION="0.8.8.5"
PKG_SHA256="77462d12ee99476c8645cb5511363e3906b88b33a6b54362b4dbc0f39aa2daad"
PKG_LICENSE="GPL"
PKG_SITE="http://modplug-xmms.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/modplug-xmms/libmodplug/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libmodplug renders mod music files as raw audio data, for playing or conversion."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"
