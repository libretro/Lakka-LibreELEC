# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet8-runtime"
PKG_VERSION="8.0.24"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="c2aa016ceb675b4c4c4f76e97803912eee9443aae13ba62b7993248be8da20d2"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.24/aspnetcore-runtime-8.0.24-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="0c88c1e201612897c0ee472008175d3b3af5e7f019e648a45f2e984cfd4ab217"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.24/aspnetcore-runtime-8.0.24-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="de0b93f2022478badc02d5cfdc733f15cb5334954605fadaddb30d5edbec51ce"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.24/aspnetcore-runtime-8.0.24-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
