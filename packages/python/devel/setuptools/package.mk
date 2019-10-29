# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="setuptools"
PKG_VERSION="41.4.0"
PKG_SHA256="185d519d6b283a10008427402cc3f834878759da279e5100b7810bc5f772ee1c"
PKG_LICENSE="OSS"
PKG_SITE="https://pypi.org/project/setuptools"
PKG_URL="https://github.com/pypa/setuptools/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python3:host"
PKG_LONGDESC="Replaces Setuptools as the standard method for working with Python module distributions."
PKG_TOOLCHAIN="manual"

make_host() {
  python3 bootstrap.py
}

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=$TOOLCHAIN
}
