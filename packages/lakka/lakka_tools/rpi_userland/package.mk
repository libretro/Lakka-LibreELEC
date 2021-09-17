PKG_NAME="rpi_userland"
PKG_VERSION="97bc8180ad682b004ea224d1db7b8e108eda4397"
PKG_ARCH="arm aarch64"
PKG_LICENSE="BSD3"
PKG_SITE="https://github.com/raspberrypi/userland"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Source code for ARM side libraries for interfacing to Raspberry Pi GPU."
PKG_TOOLCHAIN="cmake"
PKG_CMAKE_OPTS_TARGET="-DARM64=ON"

if [ "${ARCH}" = "arm" ]; then
  PKG_CMAKE_OPTS_TARGET="-DARM64=OFF"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_BUILD}/build/bin/* ${INSTALL}/usr/bin

  mkdir -p $INSTALL/usr/lib
    cp -v ${PKG_BUILD}/build/lib/* ${INSTALL}/usr/lib
}
