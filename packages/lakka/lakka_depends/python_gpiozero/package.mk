PKG_NAME="python_gpiozero"
PKG_VERSION="1.5.1"
PKG_LICENSE="BSD"
PKG_SITE="https://gpiozero.readthedocs.io/"
PKG_URL="https://github.com/gpiozero/gpiozero/archive/v${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="gpiozero-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain Python3:host Python3 RPi.GPIO distutilscross:host"
PKG_LONGDESC="A simple interface to GPIO devices with Raspberry Pi."

PKG_TOOLCHAIN="manual"

pre_make_target() {
  export PYTHONXCPREFIX="${SYSROOT_PREFIX}/usr"
  export LDSHARED="${CC} -shared"
}

make_target() {
  python setup.py build --cross-compile
}

makeinstall_target() {
  python setup.py install --root=${INSTALL} --prefix=/usr
}

post_makeinstall_target() {
  find ${INSTALL}/usr/lib -name "*.py" -exec rm -rf "{}" ";"
  rm -rf ${INSTALL}/usr/bin
}
