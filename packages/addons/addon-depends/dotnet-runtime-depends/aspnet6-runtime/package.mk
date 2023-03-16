# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.15"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="b37cf63d5962b2f67288a78b6541151c458bc9e67baaf5d5852b2214e858070b"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/0d9619a1-af06-40c6-9816-46d08c9e42d6/744ecc09a1058822dc08ae17a3dc9c77/aspnetcore-runtime-6.0.15-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="70afd74a6a070f629fcf44571582eec026442c4530f69afc142b92667542932c"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/c7eade0f-81ff-4587-a58e-647702814ec4/1b8c56efc82990ee986d8dd52a9a09ab/aspnetcore-runtime-6.0.15-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="930b6254500e53a4f0d87b5551840a3ac8882e93797cf1e23da40652085d44dd"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/4518a0d8-9a6b-4836-ada9-096afa24efd0/ad0d8ccefb6b6a36dc108417b74775cb/aspnetcore-runtime-6.0.15-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
