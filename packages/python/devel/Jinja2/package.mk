# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Jinja2"
PKG_VERSION="3.1.1"
PKG_SHA256="640bed4bb501cbd17194b3cace1dc2126f5b619cf068a726b98192a0fde74ae9"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/Jinja2/"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host MarkupSafe:host"
PKG_LONGDESC="Jinja is a fast, expressive, extensible templating engine."
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=${TOOLCHAIN}
}
