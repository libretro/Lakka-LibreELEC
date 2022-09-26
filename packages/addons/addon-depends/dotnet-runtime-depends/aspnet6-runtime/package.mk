# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.9"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="43b5536ab6f74911acafada4482add10d9544969f1ec9b3657424c421d58b912"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/bff2e771-8180-47eb-b12a-757a67001e21/63a7f79af649efe65c20f2ca56834048/aspnetcore-runtime-6.0.9-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="09b3fd3738ab48cb2738b25bb24cd352fa264a43010843713f5a4d89bbfe7033"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/eb46a420-96cb-4600-95b4-40496349fdf8/f33af6a90cc721adca490d69fa9d0e98/aspnetcore-runtime-6.0.9-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="9e05b2f6d80e50b112064a92b14dd758dd75253303fa7cd86d0c24c1baf92a51"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/1a2bca2e-f525-4ecf-9c46-06889b4ce3a4/1a7ad60df284ca6b00ca5d31cc1b1c7c/aspnetcore-runtime-6.0.9-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
