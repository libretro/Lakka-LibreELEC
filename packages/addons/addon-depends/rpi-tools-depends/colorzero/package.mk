# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="colorzero"
PKG_VERSION="2.0"
PKG_SHA256="86c9933b004aec8ce1c476d1d1129e00325c7724df3c09aa353d5f8e883ed08d"
PKG_ARCH="arm"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/waveform80/colorzero"
PKG_URL="https://github.com/waveform80/colorzero/archive/release-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Another color manipulation library for Python (originally from picamera)."
PKG_TOOLCHAIN="manual"

[ "${DISTRO}" = "Lakka" ] && PKG_DEPENDS_TARGET+=" Python3 distutilscross:host" || true

if [ "${DISTRO}" = "Lakka" ]; then
  PKG_ARCH+=" aarch64"
fi

pre_make_target() {
  if [ "${DISTRO}" = "Lakka" ]; then
    export PYTHONXCPREFIX="${SYSROOT_PREFIX}/usr"
    export LDSHARED="${CC} -shared"
  fi
}

make_target() {
  if [ "${DISTRO}" = "Lakka" ]; then
    python setup.py build --cross-compile
  fi
}

makeinstall_target() {
  if [ "${DISTRO}" = "Lakka" ]; then
    python setup.py install --root=${INSTALL} --prefix=/usr
  fi
}

post_makeinstall_target() {
  if [ "${DISTRO}" = "Lakka" ]; then
    find ${INSTALL}/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  fi
}
