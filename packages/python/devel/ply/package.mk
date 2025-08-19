# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ply"
PKG_VERSION="3.11"
PKG_SHA256="00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://pypi.org/project/ply"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host"
PKG_LONGDESC="PLY is yet another implementation of lex and yacc for Python."
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=${TOOLCHAIN}
}
