# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet9-runtime"
PKG_VERSION="9.0.12"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="b0ce7bc0ab002c8f4852991ec3d29ca55f46142168325a4767405a709c3363bd"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/9.0.12/aspnetcore-runtime-9.0.12-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="75b83e5245713470e581b238299c3f6125f16b5c5c625f7c04c7d9ce85e068be"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/9.0.12/aspnetcore-runtime-9.0.12-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="e691ad6b028fc8f4c2128ecd6a38bf13b217cff9c034d97cdc3df8ee30e688ec"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/9.0.12/aspnetcore-runtime-9.0.12-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
