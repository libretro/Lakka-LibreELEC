# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dotnet6-runtime"
PKG_VERSION="6.0.4"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC=".NET Runtime runs applications built with .NET Core, a cross-platform .NET implementation."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="672f8e8ffcf012059aef6c2f7edfe34ea307559fa2d8821bb5a4d07a4fbbbed6"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/3641affa-8bb0-486f-93d9-68adff4f4af7/1e3df9fb86cba7299b9e575233975734/dotnet-runtime-6.0.4-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="11b8c2952210e226ec9c2a996d7a6b24f4b8ddd8ae0590080bfea5362fb7e0af"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/f8e1ab66-58f7-4ebb-a9bb-9decfa03501f/88e1fb49af6f75dc54c23383162409c5/dotnet-runtime-6.0.4-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="02e2c5b5950e3fc1fe4dd146175758f198c711e495883f7f286d575437fd82c4"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/5b08d331-15ac-4a53-82a5-522fa45b1b99/65ae300dd160ae0b88b91dd78834ce3e/dotnet-runtime-6.0.4-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="dotnet-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
