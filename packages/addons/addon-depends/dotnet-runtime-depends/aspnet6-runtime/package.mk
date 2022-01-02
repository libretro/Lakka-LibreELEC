# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.1"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="0806f4be544c67b12fe236c7b7bc99e49194a172caa1b340619114fab80e633f"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/01f8a4af-9d6c-40ff-b834-a1d73105a9d5/aba0525a8b8cb745ac70ecd671acf0e0/aspnetcore-runtime-6.0.1-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="eef8e3c5a65c67d17d2d7da7382044b8f0a48c05d61e8d9e1d7bc4f77e0c7a9f"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/ff3b2714-0dee-4cf9-94ee-cb9f5ded285f/d6bfe8668428f9eb28acdf6b6f5a81bc/aspnetcore-runtime-6.0.1-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="ae7dce00eec4bc5431faacc574193b1a920d8a7e92abc4bec6288c20a8a507f6"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/32230fb9-df1e-4b86-b009-12d889cbfa8a/f57a5d92327bb2936caac94bcf602c22/aspnetcore-runtime-6.0.1-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
