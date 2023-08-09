# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.21"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="29ca9fb2308d5c927c9673c96836b144e6f0ea52041f7258ed14eb8f42dc2b15"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/1f8d7d02-581b-42f8-b74a-bf523099ab5c/29da812824f1a8cdfbe452aa5bc0ebc3/aspnetcore-runtime-6.0.21-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="d319439c053b96dd130bcad06f0a920f08b73659808cef61bc5e306bae755eed"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/d184fca4-527b-46aa-ad71-9fdf7c010262/dc0eb0bd54951de8c1eacaab795ecf24/aspnetcore-runtime-6.0.21-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="bc8cb0e3f37d08a9402119fb2f00d41f97678cad1b5ec65458ec8f489ee80e10"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/56d44b17-03c2-4d9e-bdbc-a598ca34fc01/8fcc1e19dfd3c86b09beb68460db6e85/aspnetcore-runtime-6.0.21-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
