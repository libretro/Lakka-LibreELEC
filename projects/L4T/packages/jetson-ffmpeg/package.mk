PKG_NAME="jetson-ffmpeg"
PKG_VERSION="20067187641389ba309bd3ca51933718b6b475ef"
PKG_DEPENDS_TARGET="toolchain cmake:host gcc-linaro-aarch64-linux-gnu:host tegra-bsp"
PKG_SITE="https://github.com/jocover/jetson-ffmpeg/"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_BUILD_FLAGS="-strip"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DLAKKA_API_PATH=${SYSROOT_PREFIX} -DLAKKA_BUILD_LIBS=${TOOLCHAIN}/aarch64-libreelec-linux-gnueabi/sysroot/usr/lib/"

post_makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/include
    cp -PRv ${PKG_BUILD}/nvmpi.h ${SYSROOT_PREFIX}/usr/include/nvmpi.h
}
