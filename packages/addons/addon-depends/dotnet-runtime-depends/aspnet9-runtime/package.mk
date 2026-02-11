# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet9-runtime"
PKG_VERSION="9.0.13"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="636cbf7e66dbcc3d58e855c1816731c8fbe5e130869352fb81b5ad224f5d1905"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/9.0.13/aspnetcore-runtime-9.0.13-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="d0b9b5cd8b16dd405fcb3a853d90e17fc81955800899ec51f1cca9e26c172ae0"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/9.0.13/aspnetcore-runtime-9.0.13-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="947e248fd0745b89e5708378bcd67aa20caae2ba11c3fd9bd76e3e4114966ccd"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/9.0.13/aspnetcore-runtime-9.0.13-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
