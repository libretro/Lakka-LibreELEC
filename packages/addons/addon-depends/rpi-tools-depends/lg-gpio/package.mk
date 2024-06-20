# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lg-gpio"
PKG_VERSION="0.2.2"
PKG_SHA256="b08d8569d6dc8fa91a42ba1e37f620fdcb19d6bf2330e4b7d7301431ddbe124c"
PKG_LICENSE="Unlicense"
PKG_SITE="http://abyz.me.uk/lg/"
PKG_URL="https://github.com/joan2937/lg/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 swig:host distutilscross:host"
PKG_LONGDESC="A library for Linux Single Board Computers (SBC) which allows control of the General Purpose Input Outputs (GPIO)"
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  export PYTHONXCPREFIX="${SYSROOT_PREFIX}/usr"
  export CFLAGS="${CFLAGS} -I${PKG_BUILD}"
  export LDFLAGS="${CFLAGS} -L${PKG_BUILD}"
  export LDSHARED="${CC} -shared"
}

make_target() {
  make liblgpio.so CROSS_PREFIX=${TARGET_PREFIX}
  (
    cd PY_LGPIO
    swig -python lgpio.i
    python setup.py build
  )
}

makeinstall_target() {
  if [ "${DISTRO}" = "Lakka" ]; then
    mkdir -p "${INSTALL}/usr/lib"
    cp -v ./liblgpio.so* "${INSTALL}/usr/lib"
    (
      cd PY_LGPIO
      python setup.py install --root=${INSTALL} --prefix=/usr
    )
  fi
}

post_makeinstall_target() {
  if [ "${DISTRO}" = "Lakka" ]; then
    find ${INSTALL}/usr/lib -name "*.py" -exec rm -rf "{}" ";"
    rm -rf ${INSTALL}/usr/bin
  fi
}
