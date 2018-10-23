# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="MarkupSafe"
PKG_VERSION="1.0"
PKG_SHA256="a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665"
PKG_LICENSE="GPL"
PKG_SITE="https://pypi.org/project/MarkupSafe/"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python2:host setuptools:host"
PKG_LONGDESC="MarkupSafe implements a XML/HTML/XHTML Markup safe string for Python"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  python setup.py install --prefix=$TOOLCHAIN
}
