# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="meson"
PKG_VERSION="0.46.0"
PKG_SHA256="b7df91b01a358a8facdbfa33596a47cda38a760435ab55e1985c0bff06a9cbf0"
PKG_ARCH="any"
PKG_LICENSE="Apache"
PKG_SITE="http://mesonbuild.com"
PKG_URL="https://github.com/mesonbuild/meson/releases/download/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python3:host pathlib:host"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="High productivity build system"
PKG_LONGDESC="High productivity build system"
PKG_TOOLCHAIN="manual"

make_host() {
  python3 setup.py build
}

makeinstall_host() {
  python3 setup.py install --prefix=$TOOLCHAIN --skip-build

  # Avoid using full path to python3 that may exceed 128 byte limit.
  # Instead use PATH as we know our toolchain is first.
  for f in meson mesonconf mesontest mesonintrospect wraptool; do
    sed -i '1 s/^#!.*$/#!\/usr\/bin\/env python3/' $TOOLCHAIN/bin/$f
  done
}
