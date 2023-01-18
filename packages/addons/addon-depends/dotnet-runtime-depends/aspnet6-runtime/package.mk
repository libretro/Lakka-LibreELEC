# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.12"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="0090d031615b7d49855186cff7e4cbc99636ba664880780f84ce0d5ce25e4b0b"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/8072e219-57e4-48c3-b138-2b4067844ab2/b0712ad06fd0740963bf4ba2eff7f5ea/aspnetcore-runtime-6.0.12-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="2131903c85087017ec680e44676c4eb46e7bd0a12f0683c2a7790ec75b243d75"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/57b2bdaf-8455-4b1a-b25b-5950c950bd38/471d6de036e6f367f3a4aae5252d885a/aspnetcore-runtime-6.0.12-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="dd60c551d63eb66cd9bdc7ef223c00f49341e67f8ddda2e4ab412c3ee8997765"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/4ba0f30d-0a77-4997-8d8d-1b113d60253b/5caeeb07572b0b6a26f2a82f7a4eb31d/aspnetcore-runtime-6.0.12-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
