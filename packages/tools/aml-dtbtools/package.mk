# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aml-dtbtools"
PKG_VERSION="cce100f"
PKG_SHA256="8bcaa83fcc9e85c9c04930e7411447d96a97da0809c5ecd9af91c8b554133c41"
PKG_LICENSE="free"
PKG_SITE="https://github.com/Wilhansen/aml-dtbtools"
PKG_URL="https://github.com/Wilhansen/aml-dtbtools/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="gcc:host"
PKG_LONGDESC="AML DTB Tools"

PKG_MAKE_OPTS_HOST="dtbTool"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp dtbTool $TOOLCHAIN/bin
}
