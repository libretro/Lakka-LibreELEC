# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="setuptools"
PKG_VERSION="51.1.2"
PKG_SHA256="1f3db173c1d8f8753dce0b6c18017955863fc39a0613e5c20bfdd107f331fafb"
PKG_LICENSE="OSS"
PKG_SITE="https://pypi.org/project/setuptools"
PKG_URL="https://github.com/pypa/setuptools/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host"
PKG_LONGDESC="Replaces Setuptools as the standard method for working with Python module distributions."
PKG_TOOLCHAIN="manual"

make_host() {
  python3 bootstrap.py
}

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=${TOOLCHAIN}
}
