# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.20"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="dd1898babdba27c57338b17afd4513a53025dec0985047d030336aab65532e26"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/a8a1a993-ddd9-4bcd-8386-d9defcf0fd29/4b471f72c8253fa1462ea923d0fe39a2/aspnetcore-runtime-6.0.20-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="f26a0f36339056d65522254c4bf333c940abc3dee907d4219a64cc1456b63fe3"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/872ccb13-fbc4-4d75-9d8f-be3fec5581ef/add2199206c438835b7b48a6d061b023/aspnetcore-runtime-6.0.20-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="88afcf5b6434c6a4ee12488d8bc13f84c15191712d12eb9646cf3642b9c01e86"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/972dc929-4c16-4456-a7c8-64014f80678d/a3b62252f98a0d7e0c0a9a01ede18776/aspnetcore-runtime-6.0.20-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
