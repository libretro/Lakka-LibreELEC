# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dotnet6-runtime"
PKG_VERSION="6.0.5"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC=".NET Runtime runs applications built with .NET Core, a cross-platform .NET implementation."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="0e61cffb7ef9ceed54ad759f253287ef09523825cd87ed9e84f608701abba325"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/b7bfeef6-3df9-46a1-8cc9-5b2a3121a1d7/44287ecada25d3f0bd8610550e08246d/dotnet-runtime-6.0.5-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="48aef75040b082f7c7d4222c5726f9dbf4da0d1dd8511a236fa112d2e8eac77c"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/36a5510d-e454-4f46-aeaa-ed2c9521e12e/1d60cf7759fd938f2e6c9730d0792b9d/dotnet-runtime-6.0.5-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="688694c604bbd810d28446752131e20468390a071aa2a5157a4e2d87a43dfa3c"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/56d9250f-97df-4786-b33e-a8e34b349e86/dcf054ca00899a70a80aa1a7d3072b52/dotnet-runtime-6.0.5-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="dotnet-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
