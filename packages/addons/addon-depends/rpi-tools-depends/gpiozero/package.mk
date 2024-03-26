# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gpiozero"
PKG_VERSION="1.6.2"
PKG_SHA256="0eb95a9db372146813276f92de7f43c883a3e9fe69597fc3d29c04ef3d5d5f9e"
PKG_ARCH="arm"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/RPi-Distro/python-gpiozero"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain colorzero"
PKG_LONGDESC="A simple interface to everyday GPIO components used with Raspberry Pi."
PKG_TOOLCHAIN="manual"

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
    rm -rf ${INSTALL}/usr/bin
  fi
}
