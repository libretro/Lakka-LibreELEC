# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dbussy"
PKG_VERSION="1.3"
PKG_SHA256="30a96caddcbbe7ef9e4f506c01c2d19f529cdaae6d3dac759c103b20e49641fe"
PKG_LICENSE="LGPLv2.1+"
PKG_SITE="https://gitlab.com/ldo/dbussy"
PKG_URL="https://github.com/ldo/${PKG_NAME}/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 dbus"
PKG_LONGDESC="DBussy is a wrapper around libdbus, written in pure Python"
PKG_TOOLCHAIN="manual"

make_target() {
  python3 setup.py build
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  python_remove_source
}
