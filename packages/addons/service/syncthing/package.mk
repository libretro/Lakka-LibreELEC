# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="syncthing"
PKG_VERSION="0.14.29"
PKG_SHA256="99002701279abedace88283b1381ff7850b6c20df62ae119b271ffd89716fcfd"
PKG_REV="105"
PKG_ARCH="any"
PKG_LICENSE="MPLv2"
PKG_SITE="https://syncthing.net/"
PKG_URL="https://github.com/syncthing/syncthing/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_SECTION="service/system"
PKG_SHORTDESC="Syncthing: open source continuous file synchronization"
PKG_LONGDESC="Syncthing ($PKG_VERSION) replaces proprietary sync and cloud services with something open, trustworthy and decentralized. Your data is your data alone and you deserve to choose where it is stored, if it is shared with some third party and how it's transmitted over the Internet."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Syncthing"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

configure_target() {
  export GOOS=linux
  export CGO_ENABLED=1
  export CGO_NO_EMULATION=1
  export CGO_CFLAGS=$CFLAGS
  export LDFLAGS="-w -linkmode external -extldflags -Wl,--unresolved-symbols=ignore-in-shared-libs -extld $CC -X main.Version=v$PKG_VERSION"
  export GOLANG=$TOOLCHAIN/lib/golang/bin/go
  export GOPATH=$PKG_BUILD/src/github.com/syncthing/syncthing:$PKG_BUILD/vendor:$PKG_BUILD/Godeps/_workspace
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin

  $TOOLCHAIN/lib/golang/bin/go run build.go assets

  mkdir -p $PKG_BUILD $PKG_BUILD/src/github.com/syncthing
  ln -fs $PKG_BUILD $PKG_BUILD/src/github.com/syncthing/syncthing
  ln -fs $PKG_BUILD/vendor $PKG_BUILD/vendor/src

  case $TARGET_ARCH in
    x86_64)
      export GOARCH=amd64
      ;;
    aarch64)
      export GOARCH=arm64
      ;;
    arm)
      export GOARCH=arm
      case $TARGET_CPU in
        arm1176jzf-s)
          export GOARM=6
          ;;
        *)
          export GOARM=7
          ;;
      esac
      ;;
  esac
}

make_target() {
  cd $PKG_BUILD/src/github.com/syncthing/syncthing
  mkdir -p bin
  $GOLANG build -v -o bin/syncthing -a -ldflags "$LDFLAGS" ./cmd/syncthing
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/bin/syncthing $ADDON_BUILD/$PKG_ADDON_ID/bin
}
