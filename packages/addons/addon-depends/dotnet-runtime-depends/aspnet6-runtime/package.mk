# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.16"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="eba3d57245dcc02ef7b9677a6f205d8a0b932a4aa1e552c9e9094cefab6b52c2"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/5fe35f73-59e4-462e-b7aa-98b5b8782051/74a27e03d896663a9483eb72bc59b275/aspnetcore-runtime-6.0.16-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="717d98c382cdc3abb5e25cc7437b7ffe4b195c072a233b5be44b762d374683c7"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/4054a868-d2c9-4e04-84ea-d78b6b77c8cb/f69efb40d4cc84fa5f792d0bb821eea8/aspnetcore-runtime-6.0.16-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="099a6aa6516413b88fb877d10deb1d171c1a772f1cd83cdb46003de72aec07cd"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/877a2d48-74ed-484b-85a1-605078f5e718/752ce1e38b76ffb5ebfc2ee1772307bf/aspnetcore-runtime-6.0.16-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
