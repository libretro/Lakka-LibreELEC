# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

case "$ARCH" in
  "aarch64")
    PKG_NC_ARCH="arm64"
    PKG_SHA256="f933f9c30b355265badabfa26d57731f73cbab6f626191a1fc5cee39d3e0346b"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/9cb31ef2-d5ec-490d-8a3f-f45f52d28fec/4c906b6132f2c0fe55e9e0209f08b352/dotnet-runtime-2.1.6-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_NC_ARCH="arm"
    PKG_SHA256="85ca44a63e05d9ee7601ab333dd24a0e3a3ab0bd57af056036139020d800c7ef"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/7d461733-a0cd-48ee-9963-791337dcaafa/3b75ee4c7fb9d6bc7d0ddd9761676096/dotnet-runtime-2.1.6-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_NC_ARCH="x64"
    PKG_SHA256="b7c56119afb73c31f1cebb53cad758685850c248d44fdfc571af26390f53635b"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/5c1334bc-bd26-4232-a745-2728b36a2628/8e163216cdcec15332ebf2e5575962de/dotnet-runtime-2.1.6-linux-x64.tar.gz"
    ;;
esac

PKG_NAME="dotnet-runtime"
PKG_VERSION="2.1.6"
PKG_REV="103"
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
