# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pybuild"
PKG_VERSION="1.2.1"
PKG_SHA256="526263f4870c26f26c433545579475377b2b7588b6f1eac76a001e873ae3e19d"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/build/"
PKG_URL="https://files.pythonhosted.org/packages/source/b/build/build-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="build-${PKG_VERSION}"
PKG_DEPENDS_HOST="flit:host pyproject-hooks:host pyinstaller:host pypackaging:host"
PKG_LONGDESC="A simple, correct Python build frontend."
PKG_TOOLCHAIN="python-flit"
