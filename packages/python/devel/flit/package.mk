# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flit"
PKG_VERSION="3.9.0"
PKG_SHA256="72ad266176c4a3fcfab5f2930d76896059851240570ce9a98733b658cb786eba"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/flit-core/"
PKG_URL="https://files.pythonhosted.org/packages/source/f/flit_core/flit_core-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="flit_core-${PKG_VERSION}"
PKG_DEPENDS_HOST="Python3:host"
PKG_LONGDESC="flit provides a PEP 517 build backend for packages using Flit."
PKG_TOOLCHAIN="manual"

make_host() {
  export DONT_BUILD_LEGACY_PYC=1
  python3 -m flit_core.wheel
}

makeinstall_host() {
  exec_thread_safe python3 -m bootstrap_install dist/*.whl --installdir=${TOOLCHAIN}/lib/${PKG_PYTHON_VERSION}/site-packages
}
