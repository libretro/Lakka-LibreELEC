# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="shared-mime-info"
PKG_VERSION="1.9"
PKG_SHA256="5c0133ec4e228e41bdf52f726d271a2d821499c2ab97afd3aa3d6cf43efcdc83"
PKG_LICENSE="GPL2"
PKG_SITE="https://freedesktop.org/wiki/Software/shared-mime-info/"
PKG_URL="http://freedesktop.org/~hadess/shared-mime-info-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib libxml2"
PKG_LONGDESC="The shared-mime-info package contains the core database of common types."
PKG_BUILD_FLAGS="-parallel"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
                           --disable-update-mimedb"

makeinstall_target() {
  :
}
