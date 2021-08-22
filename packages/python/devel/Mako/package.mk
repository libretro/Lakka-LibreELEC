# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Mako"
PKG_VERSION="1.1.5"
PKG_SHA256="169fa52af22a91900d852e937400e79f535496191c63712e3b9fda5a9bed6fc3"
PKG_LICENSE="GPL"
PKG_SITE="https://pypi.org/project/Mako"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host MarkupSafe:host"
PKG_LONGDESC="Mako is a super-fast templating language that borrows the best ideas from the existing templating languages."
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=${TOOLCHAIN}
}
