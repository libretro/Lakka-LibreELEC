# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

case "$ARCH" in
  "aarch64")
    PKG_NC_ARCH="arm64"
    PKG_SHA256="492de061d1e01862c2f208287c5454a19650ab2d6441554347d847656900da70"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/9e06922d-3a96-4f0d-9eb0-94f2cf94458f/93dfe5f0ad50c0eb347e98d7f81b34ec/dotnet-runtime-2.2.4-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_NC_ARCH="arm"
    PKG_SHA256="06cc0010e92591c350fe010feacdd6bb55294f89e97ea30eac5a46c33fd8d1f4"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/8c52648c-bedd-44b0-9442-95cd830fdada/d6ba4c50a6b2afddc4ae3d313349f3ac/dotnet-runtime-2.2.4-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_NC_ARCH="x64"
    PKG_SHA256="0e494df7a3936ac59c17de3b91d928bb3ab3cdd1e6734d581ad4774f551ca239"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/853048a3-764a-4b4d-a608-c6144a84f257/99c5cb1ea145f9dc3c2bbd093c682c9b/dotnet-runtime-2.2.4-linux-x64.tar.gz"
    ;;
esac

PKG_NAME="dotnet-runtime"
PKG_VERSION="2.2.4"
PKG_REV="106"
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
