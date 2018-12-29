# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

case "$ARCH" in
  "aarch64")
    PKG_NC_ARCH="arm64"
    PKG_SHA256="8baeaeb6ff7d65fbb8e7d085f7625cc4e3e2ffaecd97e80d2c5e4ca0ed598356"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/8931cb99-76f8-4d62-82be-881b79b03aac/9b31f0cbd0caac6d1639cece76d414a8/dotnet-runtime-2.2.0-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_NC_ARCH="arm"
    PKG_SHA256="248e3d43b7b46b30f9059c775b08770c377f3a90f27bbc3da188a3f7f24de75d"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/a3f3e38e-246a-4eab-8da3-63f9cd1b1c13/c2e795a9bb03bc75d3cfa767f3f77310/dotnet-runtime-2.2.0-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_NC_ARCH="x64"
    PKG_SHA256="452ea9e2fc4f84fd5d0bf17501aa99a99d33badabee23950e537a1a4dc6a2b05"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/1057e14e-16cc-410b-80a4-5c2420c8359c/004dc3ce8255475d4723de9a011ac513/dotnet-runtime-2.2.0-linux-x64.tar.gz"
    ;;
esac

PKG_NAME="dotnet-runtime"
PKG_VERSION="2.2.0"
PKG_REV="104"
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
