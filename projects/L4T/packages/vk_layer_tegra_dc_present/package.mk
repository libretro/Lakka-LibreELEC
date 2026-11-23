PKG_NAME="vk_layer_tegra_dc_present"
PKG_VERSION="2d880a93050803d5fed0cf45de8875ad3f7fdd1f"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/theofficialgman/vk_layer_tegra_dc_present"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain tegra-bsp vulkan-loader"
PKG_LONGDESC="Vulkan layer to fix tearing issues"
PKG_TOOLCHAIN="make"


PKG_MAKEINSTALL_OPTS_TARGET="LAYERLIBDIR=/usr/lib LAYERJSONDIR=/etc/vulkan/implicit_layer.d"
