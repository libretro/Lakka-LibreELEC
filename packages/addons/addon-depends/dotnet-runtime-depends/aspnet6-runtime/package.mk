# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.18"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="cae83353c508eb7766be43f6cae4e500569f3bcf8a1139e4e762c5b9f7dabbf1"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/f60912b4-b50d-4d85-b3aa-3b69504a426b/190ebc4012cd4da240e4d5247b484b15/aspnetcore-runtime-6.0.18-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="45d22a5ef4eb687648fdd4bf918e25f2fc9a63a0f84fa68a45a88ee6d44f204d"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/7b10cc0d-3627-4d1b-8307-630c05fb30be/06e4498eeb854db5a723b46114377fce/aspnetcore-runtime-6.0.18-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="8b7a6c4fc46887d1281f18558e76e34b1656ca1f487c3c71f63d3453a1f5c63b"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/503c4325-104f-41e0-8dc6-1a8b55e0651a/3dcd8a5d03d3a04bb4111296b12cd11d/aspnetcore-runtime-6.0.18-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
