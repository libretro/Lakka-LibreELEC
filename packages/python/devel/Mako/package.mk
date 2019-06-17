# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Mako"
PKG_VERSION="1.0.12"
PKG_SHA256="0cfa65de3a835e87eeca6ac856b3013aade55f49e32515f65d999f91a2324162"
PKG_LICENSE="GPL"
PKG_SITE="https://pypi.org/project/Mako"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host MarkupSafe:host"
PKG_LONGDESC="Mako is a super-fast templating language that borrows the best ideas from the existing templating languages."
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=$TOOLCHAIN
}
