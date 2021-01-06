# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dotnet-runtime"
PKG_VERSION="3.1.10"
PKG_REV="112"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.github.io/"
PKG_DEPENDS_TARGET="toolchain icu"
PKG_SECTION="tools"
PKG_SHORTDESC=".NET Core Runtime"
PKG_LONGDESC=".NET Core Runtime ($PKG_VERSION) runs applications built with .NET Core, a cross-platform .NET implementation."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME=".Net Core Runtime"
PKG_ADDON_PROJECTS="any !RPi1"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_MAINTAINER="Anton Voyl (awiouy)"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="ef11a880d59b19f1df355b3c9c8b35ea1aa37e72d179850051cad963cb72358f"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/936a9563-1dad-4c4b-b366-c7fcc3e28215/a1edcaf4c35bce760d07e3f1f3d0b9cf/aspnetcore-runtime-3.1.10-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="29c6aa914739dce59e04d1fc7dceb33e97dfec6624ec3c297a8375f66aece092"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/a2223d1f-c138-4586-8cd1-274c5387e975/623ece755546aca8f4be268f525683c5/aspnetcore-runtime-3.1.10-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="b58376e76c68f03e142ac9a771b782cb7be926a16e920d83c711903b82608f3a"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/eca743d3-030f-4b1b-bd15-3573091f1c02/f3e464abc31deb7bc2747ed6cc1a8f5c/aspnetcore-runtime-3.1.10-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -r $PKG_BUILD/* \
          $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
    cp -L $(get_install_dir icu)/usr/lib/lib*.so.?? \
          $ADDON_BUILD/$PKG_ADDON_ID/lib/
}
