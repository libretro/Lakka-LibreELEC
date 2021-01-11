# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="shared-mime-info"
PKG_VERSION="1.15"
PKG_SHA256="f482b027437c99e53b81037a9843fccd549243fd52145d016e9c7174a4f5db90"
PKG_LICENSE="GPL2"
PKG_SITE="https://freedesktop.org/wiki/Software/shared-mime-info/"
PKG_URL="https://gitlab.freedesktop.org/xdg/shared-mime-info/uploads/b27eb88e4155d8fccb8bb3cd12025d5b/shared-mime-info-1.15.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib libxml2 gettext itstool:host"
PKG_LONGDESC="The shared-mime-info package contains the core database of common types."
PKG_BUILD_FLAGS="-parallel -sysroot"

PKG_MESON_OPTS_TARGET="-Dupdate-mimedb=false"
