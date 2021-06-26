################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="vulkan-loader"
PKG_VERSION="1.2.182"
PKG_SHA256="0d1f9fde9d21642526e9baa55d30364c95035c4fe3c6db96836631991b44dd90"
PKG_ARCH="any"
PKG_LICENSE="Apache 2.0"
PKG_SITE="https://www.khronos.org"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Loader/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host Python3 vulkan-headers xrandr"
PKG_SECTION="graphics"
PKG_SHORTDESC="Vulkan Installable Client Driver (ICD) Loader."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DBUILD_WSI_WAYLAND_SUPPORT=off \
                       -DVulkanHeaders_INCLUDE_DIR=${SYSROOT_PREFIX}/usr/include \
                       -DBUILD_WSI_XCB_SUPPORT=on \
                       -DBUILD_WSI_XLIB_SUPPORT=on \
                       -DBUILD_TESTS=off"
