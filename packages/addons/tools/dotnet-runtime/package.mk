# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

case "$ARCH" in
  "aarch64")
    PKG_NC_ARCH="arm64"
    PKG_SHA256="771904d72f06eb816e5a4adbaa76c4352c097fbf5ed7dee9e4059e776278223a"
    ;;
  "arm")
    PKG_NC_ARCH="arm"
    PKG_SHA256="cbdc689bff4dc01cb89e792d34a296bf9971f251719b6d60bbe5c5caeda846c7"
    ;;
  "x86_64")
    PKG_NC_ARCH="x64"
    PKG_SHA256="dd5d52fdc439fce37b2cc706ecdaf8900c36870654bbce4ae693a66279821b2e"
    ;;
esac

PKG_NAME="dotnet-runtime"
PKG_VERSION="2.1.3"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.github.io/"
PKG_URL="https://download.microsoft.com/download/6/E/B/6EBD972D-2E2F-41EB-9668-F73F5FDDC09C/dotnet-runtime-$PKG_VERSION-linux-$PKG_NC_ARCH.tar.gz"
PKG_SOURCE_NAME="$PKG_NAME-$PKG_VERSION-$ARCH.tar.gz"
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
  cp -r $PKG_BUILD/* \
        $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/libs
  cp -L $(get_build_dir curl3)/.$TARGET_NAME/lib/.libs/libcurl.so.? \
        $(get_build_dir krb5)/.install_pkg/usr/lib/libcom_err.so.? \
        $(get_build_dir krb5)/.install_pkg/usr/lib/libgssapi_krb5.so.? \
        $(get_build_dir krb5)/.install_pkg/usr/lib/libk5crypto.so.? \
        $(get_build_dir krb5)/.install_pkg/usr/lib/libkrb5.so.? \
        $(get_build_dir krb5)/.install_pkg/usr/lib/libkrb5support.so.? \
        $(get_build_dir lttng-ust)/.install_pkg/usr/lib/liblttng-ust.so.? \
        $(get_build_dir lttng-ust)/.install_pkg/usr/lib/liblttng-ust-tracepoint.so.? \
        $ADDON_BUILD/$PKG_ADDON_ID/libs
}
