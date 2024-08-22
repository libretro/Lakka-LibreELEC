# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pyproject-hooks"
PKG_VERSION="1.0.0"
PKG_SHA256="f271b298b97f5955d53fb12b72c1fb1948c22c1a6b70b315c54cedaca0264ef5"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/pyproject-hooks/"
PKG_URL="https://files.pythonhosted.org/packages/source/p/pyproject_hooks/pyproject_hooks-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="pyproject_hooks-${PKG_VERSION}"
PKG_DEPENDS_HOST="flit:host pyinstaller:host"
PKG_LONGDESC="pyproject-hooks provides the basic functionality to help write tooling that generates distribution files from Python projects."
PKG_TOOLCHAIN="python-flit"
