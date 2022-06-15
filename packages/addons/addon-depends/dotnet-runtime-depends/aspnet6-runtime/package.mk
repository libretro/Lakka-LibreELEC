# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.6"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="e80fbf9feed47e2214c848ac66bdf10ce19ddcd5a06a05ec9b255a7915bd43fd"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/94553ccb-ce1a-401c-8840-bdffb4e9d0cb/ab8a0024df90506d953904ac38b5a978/aspnetcore-runtime-6.0.6-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="037a8add2f4c03bb23842097c5aa25fe52b87f6cd5d977237a6e579b6919f73b"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/084bfc2b-f28d-4995-87f0-d82519245825/7f5398fc2caf95355b154856868ef560/aspnetcore-runtime-6.0.6-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="38ad01d083f0f493116bd06dd80210589abc8b3d502cf81c5dc40ba0fc19d3d5"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/afd5344f-a9e9-45f9-85b5-de4551c53736/c30996daa407f9bb540ebc5edfcf16fc/aspnetcore-runtime-6.0.6-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
