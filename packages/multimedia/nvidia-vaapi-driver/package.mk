# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nvidia-vaapi-driver"
PKG_VERSION="0.0.4"
PKG_SHA256="8b99c618f530ea388964cdb3e8454de2d89f4354de8d0a0ea7941e88576d7e2a"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/elFarto/nvidia-vaapi-driver"
PKG_URL="https://github.com/elFarto/nvidia-vaapi-driver/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain nv-codec-headers gst-plugins-bad"
PKG_LONGDESC="A VA-API implemention using NVIDIA's NVDEC"
