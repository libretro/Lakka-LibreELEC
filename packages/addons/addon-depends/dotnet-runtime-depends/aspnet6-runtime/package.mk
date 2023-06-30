# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.19"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="fb4d55dd30f3956595c398477436322819fd1cf7d273a559db5e43a14435c9bb"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/86b5e7ea-d316-4b44-a543-95cbfeafadd9/7e7b8ed4c007d9290c2099b5bcd144af/aspnetcore-runtime-6.0.19-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="d9ac8112187666535e2940daa90c55606d2f62a3a267ae471c92859e25a87b60"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/f33d9dc8-1f77-48dc-89f5-8f691038d629/90926d8575953228ee5271530e08b595/aspnetcore-runtime-6.0.19-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="217e4dfb3c9469580559f5714daa3c505f36156d2bd97a15238d240c6bcc54bf"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/fb0913f6-79a8-40b6-b604-bda42b60d0c2/eb98e78d3d75c16326a54cd0277b5406/aspnetcore-runtime-6.0.19-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
