# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.4"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="6d66bf5494f4a54f6f20fe0de1e7a64a6e4eb5e6136b1496ac347d027fd35abe"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/ba1662bf-50e6-451a-957f-0d55bc6e5713/921fe0e68428ac47c098e97418d3126a/aspnetcore-runtime-6.0.4-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="f3b41cb4fa50bb195957c53f096817e1ab19f29858a677180145eba064ea49f6"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/adc5bbf5-6cf6-4da6-be27-60de0b8739e5/fecb289bd70834203f2397c18c82bbde/aspnetcore-runtime-6.0.4-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="ca3dc696af0a9fc5c7ce052eba38ecf723cbc30d1dc29d8f85c201eff534d73b"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/de3f6658-5d5b-4986-aeb1-7efdf5818437/7df572051df15117a0f52be1b79e1823/aspnetcore-runtime-6.0.4-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
