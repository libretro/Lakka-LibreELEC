# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pypackaging"
PKG_VERSION="24.1"
PKG_SHA256="026ed72c8ed3fcce5bf8950572258698927fd1dbda10a5e981cdf0ac37f4f002"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/build/"
PKG_URL="https://files.pythonhosted.org/packages/source/p/packaging/packaging-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="packaging-${PKG_VERSION}"
PKG_DEPENDS_HOST="flit:host pyinstaller:host"
PKG_LONGDESC="Reusable core utilities for various Python Packaging interoperability specifications."
PKG_TOOLCHAIN="python-flit"
