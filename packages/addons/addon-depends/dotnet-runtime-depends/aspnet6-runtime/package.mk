# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.5"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="70dc0a73b71761a2f717bf8917f7ea4a1be4c41d2cffbe29df68f38d26e8061e"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/8ba7087e-4513-41e5-8359-a4bcd2a3661f/e6828f0d8cf1ecc63074c9ff57685e27/aspnetcore-runtime-6.0.5-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="cfc2046f516d89cec3b0052029044691448f8dcd0a3e8779776a234124846308"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/eda01ff6-fb9f-49ce-bdc1-67c688f9f1fa/75b195f97f4b219fccbac4432a6afaf0/aspnetcore-runtime-6.0.5-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="95a3cc7c4e7de792e39e40ffda72127ba49a49604b61fee18d50f970c9c1e903"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/a0e9ceb8-04eb-4510-876c-795a6a123dda/6141e57558eddc2d4629c7c14c2c6fa1/aspnetcore-runtime-6.0.5-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
