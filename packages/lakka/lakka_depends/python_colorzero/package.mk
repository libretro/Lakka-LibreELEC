PKG_NAME="python_colorzero"
PKG_VERSION="1.1"
PKG_LICENSE="BSD"
PKG_SITE="https://colorzero.readthedocs.io/"
PKG_URL="https://github.com/waveform80/colorzero/archive/release-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="colorzero-release-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain Python3:host Python3 distutilscross:host"
PKG_SECTION="python"

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
}
