# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="liblogging"
PKG_VERSION="1.0.5"
PKG_SHA256="310dc1691279b7a669d383581fe4b0babdc7bf75c9b54a24e51e60428624890b"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.liblogging.org/"
PKG_URL="http://download.rsyslog.com/liblogging/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_SHORTDESC="liblogging"
PKG_LONGDESC="liblogging"

PKG_CONFIGURE_OPTS_TARGET="--disable-man-pages \
                           --enable-static --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
