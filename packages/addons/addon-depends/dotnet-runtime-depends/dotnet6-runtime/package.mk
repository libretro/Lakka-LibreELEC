# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dotnet6-runtime"
PKG_VERSION="6.0.1"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC=".NET Runtime runs applications built with .NET Core, a cross-platform .NET implementation."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="193df0b397d3b154ced255098fdabd017ea8faac00f77485cc1a9fdab7407e4a"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/002742a9-8107-4434-a208-863f07e09397/75884224d828a34b7c5f070df5213553/dotnet-runtime-6.0.1-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="3aa29dc8f9ada9f61a2b2d77fe385b8ef15e15b8f83d4696ed711f66b02e8df7"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/bdea32df-7ab8-47f5-8f8c-3de28d5771d0/c839293beeace695b6698debaedd345e/dotnet-runtime-6.0.1-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="f77369477ee8c98402793a2b6ce1f46d663fd0373a93a4cef50eb22d8607773c"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/be8a513c-f3bb-4fbd-b382-6596cf0d67b5/968e205c44eabd205b8ea98be250b880/dotnet-runtime-6.0.1-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="dotnet-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
