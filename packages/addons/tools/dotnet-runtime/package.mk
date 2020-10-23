# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dotnet-runtime"
PKG_VERSION="3.1.9"
PKG_REV="111"
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
    PKG_SHA256="1ffe06b0012feb52d75e748438695e11905343890de73a594e6540d535fd084c"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/dffd493f-9eb8-483f-81c7-a9e2201574ef/54e7464241e01e7031fd89e6fe88e6da/aspnetcore-runtime-3.1.9-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="496247dc5098a506accb0c3286f82e497a6da30f4d0b8262c29484c096d5f717"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/c8cd43dd-e9de-4ff9-9cea-2f02fba6869c/d5c653c12ec93cb71e30b21856acea66/aspnetcore-runtime-3.1.9-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="b47a882277d4ef42d3cfebbd1f334559b8345fe8a8b05e2a7d83a37ffe5f775e"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/933b0cb8-3494-4ca4-8c9e-1bcfd3568ab0/8704eef073efdfecdaaad4a18beb05ac/aspnetcore-runtime-3.1.9-linux-x64.tar.gz"
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
