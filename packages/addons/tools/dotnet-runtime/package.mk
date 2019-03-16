# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

case "$ARCH" in
  "aarch64")
    PKG_NC_ARCH="arm64"
    PKG_SHA256="ceb6adf82fb010508124d72746bc4a5df97814de47d84d03b6df0d6598030fcd"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/07657a0c-b079-4616-9d62-d3d39202f9af/406eb81bef25fe3e3030a9cc63a69c12/dotnet-runtime-2.2.3-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_NC_ARCH="arm"
    PKG_SHA256="3eaa645dbe95957d8adb94da5f4334b0fd65a18cb3f9d92eba89a53fef6b7f6a"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/b12c61f5-7ba4-47f1-93f0-d2280fa4bf3c/8e1ae5ac780c61e0339d0247e7d9a8d8/dotnet-runtime-2.2.3-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_NC_ARCH="x64"
    PKG_SHA256="ae4aeb1e96c447b59ee9e9a2d08b6c9ec7a82bc06222819828ec165d704f05e8"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/28271651-a8f6-41d6-9144-2d53f6c4aac4/bb29124818f370cd08c5c8cc8f8816bf/dotnet-runtime-2.2.3-linux-x64.tar.gz"
    ;;
esac

PKG_NAME="dotnet-runtime"
PKG_VERSION="2.2.3"
PKG_REV="105"
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

unpack() {
  mkdir -p $PKG_BUILD
  $SCRIPTS/extract $PKG_NAME $PKG_BUILD
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -r $PKG_BUILD/$PKG_NAME-$PKG_VERSION/* \
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
