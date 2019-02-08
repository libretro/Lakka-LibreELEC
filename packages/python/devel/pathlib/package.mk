# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pathlib"
PKG_VERSION="1.0.1"
PKG_SHA256="6940718dfc3eff4258203ad5021090933e5c04707d5ca8cc9e73c94a7894ea9f"
PKG_LICENSE="MIT"
PKG_SITE="http://pathlib.readthedocs.org"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python3:host"
PKG_LONGDESC="This module offers a set of classes featuring all the common operations on paths in an easy, object-oriented way"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=$TOOLCHAIN
}
