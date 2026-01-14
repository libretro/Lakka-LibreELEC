# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet8-runtime"
PKG_VERSION="8.0.23"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="b7b0ce6b3cb802aee04ac03ccc978b12a1b1d22a1b66a40d701ed43d35724a81"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.23/aspnetcore-runtime-8.0.23-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="c4b3b74abafc2e2e0a41fbc46ca4673dca1cd1ceea4c786e8fb14c13d9bd9d5a"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.23/aspnetcore-runtime-8.0.23-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="c456d2166defbf3c13372c54b0f2a6934da98279474ea7410115d7a5090f2204"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.23/aspnetcore-runtime-8.0.23-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
