# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.11"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="b9960c5a343903e38ef84ee8ef00551330b7a64b3fb4d75d8cd2ddd29a23841e"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/e25f7ff2-9932-41dd-b549-5b4409b5a727/d00786aeabad50cd661e959a576f8777/aspnetcore-runtime-6.0.11-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="4bec937852e3a0660a57243c19a5b1d2375047de2aa1df972bc587b410ea660b"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/4072393d-3350-41d2-98e2-dc46fd930fae/6f09e1d7685fbbc01f6d84b1140e1b49/aspnetcore-runtime-6.0.11-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="d499a4af84cc3f9947230392f10d5af5fda65a71e002554f2ea3cd4244538133"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/0a17a9f6-7705-4b47-aead-c0b582cad317/158b62e5183281e416994d56ce81bc0c/aspnetcore-runtime-6.0.11-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
