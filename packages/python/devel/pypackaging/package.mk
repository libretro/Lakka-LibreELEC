# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pypackaging"
PKG_VERSION="24.2"
PKG_SHA256="c228a6dc5e932d346bc5739379109d49e8853dd8223571c7c5b55260edc0b97f"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/build/"
PKG_URL="https://files.pythonhosted.org/packages/source/p/packaging/packaging-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="packaging-${PKG_VERSION}"
PKG_DEPENDS_HOST="flit:host pyinstaller:host"
PKG_LONGDESC="Reusable core utilities for various Python Packaging interoperability specifications."
PKG_TOOLCHAIN="python-flit"
