PKG_NAME="vulkan-loader"
PKG_VERSION="1.2.173"
PKG_SHA256="a64fdd5ba78ca6cd168bbcfed9b7fc24d1eac4146db4b795299d4ea92815e470"
PKG_LICENSE="Apache 2.0"
PKG_SITE="https://www.khronos.org"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Loader/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host Python3 vulkan-headers xrandr"
PKG_LONGDESC="Vulkan Installable Client Driver (ICD) Loader."

PKG_CMAKE_OPTS_TARGET="-DBUILD_WSI_WAYLAND_SUPPORT=off \
                       -DVulkanHeaders_INCLUDE_DIR=${SYSROOT_PREFIX}/usr/include \
                       -DBUILD_WSI_XCB_SUPPORT=on \
                       -DBUILD_WSI_XLIB_SUPPORT=on \
                       -DBUILD_TESTS=off"
