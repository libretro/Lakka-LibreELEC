# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet8-runtime"
PKG_VERSION="8.0.20"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="eceeb83b41370463a94dc69941f3a5d84e8b4eee635129c990a27eddd2ba2cd4"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.20/aspnetcore-runtime-8.0.20-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="9027c5112a30e40c9926cde7337ae5c10f231e388d1191bd20ca618f8afd87ff"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.20/aspnetcore-runtime-8.0.20-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="58490d1f153c78f7c01ec6fe9354099eac0a0dc0e72f806b41b9cdb44b9aea32"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.20/aspnetcore-runtime-8.0.20-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
