# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

case "$ARCH" in
  "aarch64")
    PKG_NC_ARCH="arm64"
    PKG_SHA256="48d58ac6ff958ec7155befe76f83e276aceff50c4a7d1f578444a9a40720e412"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/f5e04830-50fc-435c-8bb5-fcd4629da944/8aa7cce5c3fcb6a7db180b923d3574ef/dotnet-runtime-2.2.6-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_NC_ARCH="arm"
    PKG_SHA256="a4f2e63471c296b7b173105a2c1d5feb95b81e0a8131f73aeecc00440fa5f544"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/428aaa32-f66c-4847-b845-aa21f90504e4/1cf033db866414997140c2672bd75069/dotnet-runtime-2.2.6-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_NC_ARCH="x64"
    PKG_SHA256="e30d4568c62d747b030e3c74f3d528ecb8d5c90e844e506bc0e3fcbce52b8cb1"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/9f21e352-9d2c-4e3b-af45-915da89158db/0e8a7ea83cc08d4bcf417a927a36ed6f/dotnet-runtime-2.2.6-linux-x64.tar.gz"
    ;;
esac

PKG_NAME="dotnet-runtime"
PKG_VERSION="2.2.6"
PKG_REV="107"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.github.io/"
PKG_DEPENDS_TARGET="toolchain curl curl3 krb5 lttng-ust"
PKG_SECTION="tools"
PKG_SHORTDESC=".NET Core Runtime"
PKG_LONGDESC=".NET Core Runtime ($PKG_VERSION) runs applications built with .NET Core, a cross-platform .NET implementation."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME=".Net Core Runtime"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_MAINTAINER="Anton Voyl (awiouy)"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -r $PKG_BUILD/* \
        $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/libs
  cp -L $(get_build_dir curl3)/.install_pkg/usr/lib/libcurl.so.? \
        $(get_build_dir krb5)/.install_pkg/usr/lib/libcom_err.so.? \
        $(get_build_dir krb5)/.install_pkg/usr/lib/libgssapi_krb5.so.? \
        $(get_build_dir krb5)/.install_pkg/usr/lib/libk5crypto.so.? \
        $(get_build_dir krb5)/.install_pkg/usr/lib/libkrb5.so.? \
        $(get_build_dir krb5)/.install_pkg/usr/lib/libkrb5support.so.? \
        $(get_build_dir lttng-ust)/.install_pkg/usr/lib/liblttng-ust.so.? \
        $(get_build_dir lttng-ust)/.install_pkg/usr/lib/liblttng-ust-tracepoint.so.? \
        $ADDON_BUILD/$PKG_ADDON_ID/libs
}
