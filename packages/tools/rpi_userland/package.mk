PKG_NAME="rpi_userland"
PKG_VERSION="0093675e4aa6e152a3ffc318b51a124e96eb287b"
PKG_SHA256="c7bfdb9fe5f4ee82ddab8383707ed287392ba85a458440ffd26ac6e74214c219"
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
