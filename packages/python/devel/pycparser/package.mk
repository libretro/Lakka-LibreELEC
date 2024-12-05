# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pycparser"
PKG_VERSION="2.22"
PKG_SHA256="491c8be9c040f5390f5bf44a5b07752bd07f56edf992381b05c701439eec10f6"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://pypi.org/project/pycparser/"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host"
PKG_LONGDESC="Complete C99 parser in pure Python"
PKG_TOOLCHAIN="python"
