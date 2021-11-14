PKG_NAME="gcc-linaro-aarch64-linux-gnu"
PKG_VERSION="6.4.1-2018.05"
PKG_VERSION_SHORT="6.4-2018.05"
PKG_LICENSE="GPL"
PKG_SITE="https://www.linaro.org"
PKG_URL="https://releases.linaro.org/components/toolchain/binaries/${PKG_VERSION_SHORT}/aarch64-linux-gnu/gcc-linaro-${PKG_VERSION}-x86_64_aarch64-linux-gnu.tar.xz"
PKG_SOURCE_DIR="gcc-linaro-${PKG_VERSION}-x86_64_aarch64-linux-gnu"
PKG_SECTION="lang"
PKG_LONGDESC="GNU C compiler/toolchain for cross-compile"
PKG_TOOLCHAIN="make"

make_host() {
  :
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/lib/gcc-linaro-aarch64-linux-gnu/
  cp -a * ${TOOLCHAIN}/lib/gcc-linaro-aarch64-linux-gnu
}
