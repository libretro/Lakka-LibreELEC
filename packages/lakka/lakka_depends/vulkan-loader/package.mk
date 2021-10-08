PKG_NAME="vulkan-loader"
PKG_VERSION="1.2.187"
PKG_SHA256="8edd4b119deec9b28d9618a1f6209e7fb627023a61bbbd56c1121e16dd77f872"
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
