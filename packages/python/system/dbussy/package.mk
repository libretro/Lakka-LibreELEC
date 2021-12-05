# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dbussy"
PKG_VERSION="a694e3b525e988dc5362f2278e2aacdf06b3a179"   # 2021-11-07
PKG_SHA256="862df448c4bccb3f08e21ed855e5c825c241d2071e923245d7d969dc2c2451f7"
PKG_LICENSE="LGPLv2.1+"
PKG_SITE="https://gitlab.com/ldo/dbussy"
PKG_URL="https://github.com/ldo/${PKG_NAME}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 dbus"
PKG_LONGDESC="DBussy is a wrapper around libdbus, written in pure Python"
PKG_TOOLCHAIN="manual"

make_target() {
  python3 setup.py build
}

makeinstall_target() {
  python3 setup.py install --root=${INSTALL} --prefix=/usr
}

post_makeinstall_target() {
  python_remove_source
}
